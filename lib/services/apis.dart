import 'package:crm_firebase_test/homePage.dart';
import 'package:crm_firebase_test/modals/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ApiServices {
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      await addUserToDesignerCollection(userCredential.user, context);
    } catch (e) {
      if (kDebugMode) {
        print("Failed to sign in with email and password:$e");
      }
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
    final regDesigner = userModal(id: user.uid, email: user.email.toString());

    if (designer.exists) {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        CupertinoPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      try {
        await designers.doc(user.uid).set(regDesigner.toJson()).then(
              (value) => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ),
            );
      } catch (e) {
        if (kDebugMode) {
          print("Error adding designer to collection :$e");
        }
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendMessageToCustomer(
    String designerId,
    String customerId,
    String message,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('chats').doc().set({
        'senderId':
            designerId, // Assuming designerId is the ID of the current designer
        'receiverId': customerId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error sending message to customer: $e");
      }
    }
  }
}
