import 'package:coffeeapp/components/botton_nav_bar.dart';
import 'package:coffeeapp/const.dart';
import 'package:coffeeapp/pages/cart_page.dart';
import 'package:coffeeapp/pages/shop_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/email_service.dart';
import 'about_page.dart';
import 'coffee_manager.dart';

class HomePage extends StatefulWidget {
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    
int _selectedIndex = 0;
  User? user;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = currentUser;
    });
  }
  final EmailService emailService = EmailService();

  void navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [ShopPage(), CartPage()];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottonNavBar(onTopChange: navigateBottomNavBar),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Padding(
              padding: EdgeInsets.all(14),
              child: Icon(Icons.menu, color: Colors.black),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Image.asset(
              "lib/images/espresso.png",
              height: 160,
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Divider(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 25, bottom: 25),
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
            ),
            if ("str8546200@gmail.com" == user?.email)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoffeeManager(),
                  ),
                );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 25, bottom: 25),
                  child: ListTile(
                    leading: Icon(Icons.manage_accounts),
                    title: Text('manage prouducts'),
                  ),
                ),
              )
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
