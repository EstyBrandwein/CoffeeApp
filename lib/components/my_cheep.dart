import 'package:flutter/material.dart';

class MyCheep extends StatelessWidget {
  final String text;
  final bool isSelected;
  const MyCheep({required this.isSelected, required this.text});
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: isSelected?Colors.white:Colors.grey,

        ),
      ),
      backgroundColor: isSelected?Colors.brown[400]:Colors.grey[100],
      padding: EdgeInsets.all(16),
      );
  }
}
