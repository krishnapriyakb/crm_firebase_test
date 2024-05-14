import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_firebase_test/chatPage.dart';
import 'package:crm_firebase_test/loginPage.dart';
import 'package:crm_firebase_test/modals/user_modal.dart';
import 'package:crm_firebase_test/services/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data?.docs;
                    List<userModal> customers = data
                            ?.map(
                              (e) => userModal.fromJson(
                                e.data(),
                              ),
                            )
                            .toList() ??
                        [];

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ChatPage(
                              customer: customers[index],
                            ),
                          ),
                        );
                      },
                      tileColor: Colors.green[100],
                      title: Text(customers[index].email),
                    );
                  });
            },
          )),
    );
  }
}
