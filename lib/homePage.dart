import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_firebase_test/chatPage.dart';
import 'package:crm_firebase_test/loginPage.dart';
import 'package:crm_firebase_test/services/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ApiServices apiServices = ApiServices();
              apiServices.signOut().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                  );
            },
            child: const Icon(Icons.power_settings_new_outlined),
          ),
          body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('customers').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var customer = snapshot.data!.docs[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ChatPage(),
                          ),
                        );
                      },
                      tileColor: Colors.green[100],
                      title: Text(customer['email']),
                    );
                  });
            },
          )),
    );
  }
}
