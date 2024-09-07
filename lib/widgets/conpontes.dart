import 'package:flutter/material.dart';

Widget textfromfield( String entertext, var controller){
  return TextFormField(
    controller: controller,
          
            decoration:  InputDecoration(border: const OutlineInputBorder(), hintText:entertext),
          );
}

Widget buttonDesign( String entertext, ontap){
  return Center(
    child: Container(
      height: 35, 
      width: 250, 
      color: const Color.fromARGB(255, 6, 38, 150),
      child: TextButton(onPressed: ontap, child:  Text(entertext, style: const TextStyle(color: Colors.white),)),
    ),
  );
}