// ignore_for_file: use_build_context_synchronously

import 'package:dfine_task/routers.dart';
import 'package:dfine_task/widgets/conpontes.dart';
import 'package:flutter/material.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController enterEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text("forgot password",style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),)),
          const SizedBox(
            height: 15,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: textfromfield("email", enterEmail),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("enter the email address you used to create your account and we will email you a link to reset your password", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
          const SizedBox(
            height: 30,
          ),
          buttonDesign("continue", () async{
           
           
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
