import 'package:coffeeapp/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "About",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
