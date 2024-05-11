import 'package:crm_firebase_test/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiServices {
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await addUserToDesignerCollection(userCredential.user, context);
    } catch (e) {
      print("Failed to sign in with email and password:$e");
    }
  }

  Future<void> addUserToDesignerCollection(
      User? user, BuildContext context) async {
    if (user == null) {
      return;
    }
    CollectionReference designers =
        FirebaseFirestore.instance.collection("designers");
    var designer = await designers.doc(user.uid).get();

    if (designer.exists) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const HomePage()));
    } else {
      await designers.doc(user.uid).set({'email': user.email}).then(
        (value) => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const HomePage()),
        ),
      );
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendMessage(
      String chatId, String senderId, String messageText) async {
    CollectionReference messages = FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatId)
        .collection('messages');

    await messages.add({
      'senderId': senderId,
      'messageText': messageText,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
