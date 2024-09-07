// ignore_for_file: use_build_context_synchronously

import 'package:dfine_task/routers.dart';
import 'package:dfine_task/widgets/conpontes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController enterEmail = TextEditingController();
  TextEditingController enterPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Center(
            child: Image.asset("assets/images/logo.png")),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: textfromfield("email", enterEmail),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
            child: textfromfield("password", enterPassword),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 10),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routers.forgotpage);
                },
                child: const Text("Forgot password?")),
          ),
          const SizedBox(
            height: 30,
          ),
          buttonDesign("continue", () async {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: enterEmail.text.trim(),
                password: enterPassword.text.trim());
            Navigator.pushNamed(context, Routers.homepage);
            enterEmail.clear();
            enterPassword.clear();
          }),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Dont't have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routers.registerpage);
                  },
                  child: const Text("Register"))
            ],
          )
        ],
      ),
    );
  }
}
