import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_firebase_test/assign_page.dart';
import 'package:crm_firebase_test/chatPage.dart';
import 'package:crm_firebase_test/loginPage.dart';
import 'package:crm_firebase_test/modals/customer_modal.dart';
import 'package:crm_firebase_test/modals/designer_modal.dart';
import 'package:crm_firebase_test/services/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User get currentDesigner => auth.currentUser!;
  DesignerModal? designerModal;
  bool isLoading = true;

  List<String> assignedCustomersList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDesignerData();
  }

  fetchDesignerData() async {
    designerModal = await ApiServices.getDesignerData();
    assignedCustomersList = designerModal!.assignedCustomers;
    log(assignedCustomersList.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const AssignPage()));
                    },
                    icon: const Icon(Icons.done_all),
                  )
                ],
                title: Text(designerModal!.email.toString()),
              ),
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
                stream: FirebaseFirestore.instance
                    .collection('customers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data!.docs;
                  List<CustomerModal> customers = data
                      .map(
                        (e) => CustomerModal.fromJson(
                          e.data(),
                        ),
                      )
                      .toList();
                  List<CustomerModal> assignedCustomersModalList = customers
                      .where(
                        (customer) =>
                            assignedCustomersList.contains(customer.id),
                      )
                      .toList();

                  return assignedCustomersModalList.isEmpty
                      ? const Center(child: Text("No customers found"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: assignedCustomersModalList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ChatPage(
                                        customer:
                                            assignedCustomersModalList[index],
                                      ),
                                    ),
                                  );
                                },
                                tileColor: Colors.green[100],
                                title: Text(
                                    assignedCustomersModalList[index].email),
                              ),
                            );
                          });
                },
              )),
    );
  }
}
