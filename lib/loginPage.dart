import 'package:crm_firebase_test/services/apis.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Email"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
              controller: passController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Password")),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              ApiServices apiServices = ApiServices();
              apiServices.signInWithEmail(
                  "abc123@gmail.com", "abc123", context);
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text("Login"),
          )
        ],
      ),
    ));
  }
}
