// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfine_task/routers.dart';
import 'package:dfine_task/widgets/conpontes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController enterName = TextEditingController();
  TextEditingController enterEmail = TextEditingController();
  TextEditingController enterPassword = TextEditingController();
  TextEditingController enterConfirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Center(child: Text("create an Account", style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),)),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: textfromfield("Full name", enterName),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
            child: textfromfield("Email", enterEmail),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
            child: textfromfield("password", enterPassword),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
            child: textfromfield("confirm password", enterConfirmpassword),
          ),
          const SizedBox(
            height: 30,
          ),
          buttonDesign("continue", ()  async{
           if(enterPassword.text==enterConfirmpassword.text)
           {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(email: enterEmail.text.trim(), password: enterPassword.text.trim());
            await FirebaseFirestore.instance.collection("userInfo").add({
              "fullname":enterName.text.trim(),
              "Email":enterEmail.text.trim(),
              "password":enterPassword.text.trim(),
              "confirmpassword":enterConfirmpassword.text.trim(),

            });

            enterName.clear();
             enterEmail.clear();
              enterPassword.clear();
              enterConfirmpassword.clear();
             
             Navigator.pushNamed(context, Routers.loginpage);

            


           }
           else{print("object");}
          }),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(onPressed: () {
                Navigator.pushNamed(context, Routers.loginpage);
              }, child: const Text("Log in"))
            ],
          )
        ],
      ),
    );
  }
}
