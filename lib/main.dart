import 'package:coffeeapp/model/coffee_shop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fireBaseOption.dart';
import 'pages/intro_screen.dart';
import 'pages/login_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoffeeShope(),
      builder: (context,child)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
