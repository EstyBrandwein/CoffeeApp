import 'package:flutter/material.dart';

class MyTextfeild extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;

  const MyTextfeild({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.focusNode
  });

  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: InputDecoration(
         enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
            borderRadius: BorderRadius.circular(12),
         ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.transparent,
          filled: true,
          hintStyle: TextStyle(color: Colors.brown),
          hintText: hintText,
        ),
      ),
    );
  }

}
