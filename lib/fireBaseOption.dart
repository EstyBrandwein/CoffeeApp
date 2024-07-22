import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/services.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyBp8No0vvmI85xM31MHTv4JoqiRK-bz1Wc',
      appId: '1:917211938577:android:0ea7c7947ea5c4291dd6b0',
      projectId: 'coffee-8e67f',
      messagingSenderId: '917211938577',
      storageBucket: 'coffee-8e67f.appspot.com'
      );
}
