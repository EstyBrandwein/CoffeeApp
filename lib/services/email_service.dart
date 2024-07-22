import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  String email = "str8546200@gmail.com";
  String code = "";
  final CollectionReference emails =
      FirebaseFirestore.instance.collection('emails');
  final smtpServer = gmail('ohadleib@gmail.com', 'bcep gayq pxzx oxkf');
  Future<void> sendEmail(String email, String subject, String text) async {
    this.email = email;
    final message = Message()
      ..from = Address("str8546200@gmail.com", 'Coffee App')
      ..recipients.add(email)
      ..subject = subject
      ..text = text;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent: \n' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<void> sendVerificationEmail(String email) async {
    code = _generateVerificationCode();
    await sendEmail(
        email, 'Verification Code', 'Your verification code is: $code');
  }

  Future<void> sendOrderDetails(
      String email, String orderDetails, String total) async {
    await sendEmail(email, 'Your Order Details',
        'Order Details:\n$orderDetails\n\nTotal: \$$total');
  }

  String _generateVerificationCode() {
    final random = Random();
    return List.generate(6, (index) => random.nextInt(10).toString()).join();
  }
    
Future<bool> isEmailRegistered(String email) async {
    try {
      final querySnapshot = await emails.where('email', isEqualTo: email).get();
      print('Checking if email is registered: ${querySnapshot.docs.isNotEmpty}');
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email registration: $e');
      return false;
    }
  }

  Future<void> registerEmail(String email) async {
    try {
      await emails.add({'email': email});
      print('Email $email registered in Firestore');
    } catch (e) {
      print('Error registering email: $e');
    }
  }
}
