import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final Function()? onTap;
  final String text;


  const MyButton({
    required this.onTap,
    required this.text
  });

  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold, 
              ),
          ),
        ),
      ),
    );
  }
}