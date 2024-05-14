import 'package:crm_firebase_test/modals/user_modal.dart';
import 'package:crm_firebase_test/services/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final userModal customer;
  ChatPage({super.key, required this.customer});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.email),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ApiServices apiServices = ApiServices();
            apiServices.sendMessageToCustomer(
                user.uid, widget.customer.id, "hello world");
          },
          child: const Text("send"),
        ),
      ),
    );
  }
}
