import 'package:crm_firebase_test/homePage.dart';
import 'package:crm_firebase_test/modals/customer_modal.dart';
import 'package:crm_firebase_test/modals/message_modal.dart';
import 'package:crm_firebase_test/modals/designer_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ApiServices {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  static User get currentDesigner => auth.currentUser!;

  static late DesignerModal me;
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
    final regDesigner = DesignerModal(
        id: user.uid,
        email: user.email.toString(),
        assignedCustomers: [],
        accId: '');

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

  static Future<DesignerModal?> getDesignerData() async {
    try {
      final designerDoc = await fireStore
          .collection('designers')
          .doc(currentDesigner.uid)
          .get();
      if (designerDoc.exists) {
        me = DesignerModal.fromJson(designerDoc.data()!);
        return me;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting current designer data :$e");
      }
      return null;
    }
  }

  static String getConversationId(String customerId) =>
      currentDesigner.uid.hashCode <= customerId.hashCode
          ? '${currentDesigner.uid}_$customerId'
          : '${customerId}_${currentDesigner.uid}';

  static Future<void> sendMessage(
      CustomerModal customer, String msg, MessageType type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final MessageModal message = MessageModal(
        customWidgets: CustomWidgets(
            imageUrls: [],
            bodyText: [],
            audioUrls: [],
            confirmationStatus: 0,
            confirmationType: "Material"),
        toId: customer.id,
        dlvryTime: time,
        frId: currentDesigner.uid,
        message: msg,
        type: type);

    final ref = fireStore
        .collection('chats/${getConversationId(customer.id)}/messages/');
    ref.doc(time).set(message.toJson());
  }

  // Future<void> sendMessageToCustomer(
  //   String designerId,
  //   String customerId,
  //   String message,
  // ) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('chats').doc().set({
  //       'senderId':
  //           designerId, // Assuming designerId is the ID of the current designer
  //       'receiverId': customerId,
  //       'message': message,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error sending message to customer: $e");
  //     }
  //   }
  // }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      CustomerModal customer) {
    return fireStore
        .collection('chats/${getConversationId(customer.id)}/messages/')
        .orderBy('dlvryTime', descending: true)
        .snapshots();
  }

  Future<List<CustomerModal>> fetchAllCustomers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('customers').get();

    List<CustomerModal> customers = snapshot.docs.map((doc) {
      return CustomerModal.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return customers;
  }

  Future<List<DesignerModal>> fetchAllDesigners() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('designers').get();

    List<DesignerModal> designers = snapshot.docs.map((doc) {
      return DesignerModal.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return designers;
  }

  Future<void> assignDesignerToCustomer(
      String designerId, String customerId) async {
    // Add designerId to the assignedDesigner list in Customer collection
    await fireStore.collection('customers').doc(customerId).update({
      'assignedDesigner': FieldValue.arrayUnion([designerId]),
    });

    // Add customerId to the assignedCustomers list in Designer collection
    await fireStore.collection('designers').doc(designerId).update({
      'assignedCustomers': FieldValue.arrayUnion([customerId]),
    });
  }

  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
