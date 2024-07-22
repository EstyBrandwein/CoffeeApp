import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottonNavBar extends StatelessWidget {
  final void Function(int)? onTopChange;

  const MyBottonNavBar({required this.onTopChange});
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      child: GNav(
        onTabChange: onTopChange,
        color: Colors.grey[400],
        activeColor: Colors.grey[700],
        tabBorderRadius: 24,
        tabBackgroundColor: Colors.grey.shade300,
        tabActiveBorder: Border.all(color: Colors.white),
        gap: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Shop',
          ),
          GButton(
            icon: Icons.shopping_bag_rounded,
            text: 'cart',
          )
        ],
      ),
    );
  }
}
