import 'package:dfine_task/screens/addtask.dart';
import 'package:dfine_task/screens/forgotpassword.dart';
import 'package:dfine_task/screens/homepage.dart';
import 'package:dfine_task/screens/loginpage.dart';
import 'package:dfine_task/routers.dart';
import 'package:dfine_task/screens/profile.dart';
import 'package:dfine_task/screens/registerpage.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routers.loginpage,
      routes: {
        Routers.loginpage:(context)=> const Loginpage(),
         Routers.registerpage:(context)=> const Registerpage(),
         Routers.homepage:(context)=> const Homepage(),
         Routers.forgotpage:(context)=> const Forgotpassword(),
         Routers.addtask:(context)=>const Addtask(),
         Routers.profilepage:(context)=>const Profile(),
      },
    );
  }
}