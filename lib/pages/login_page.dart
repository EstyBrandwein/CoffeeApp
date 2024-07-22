import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/email_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPhoneSelected = true;
  bool isSend = false;
  final TextEditingController _phoneEmailController = TextEditingController();
  final TextEditingController _phoneEmailTrustController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailService emailService = EmailService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/images/iced_coffee.png', // Make sure to add your image asset here
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                'היי, ברוכים הבאים',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'הזינו את מספר הטלפון או המייל על מנת להיכנס',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ToggleButtons(
                borderColor: Colors.grey,
                fillColor: Colors.brown[100],
                borderWidth: 2,
                selectedBorderColor: Colors.brown,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('טלפון'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('מייל'),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    isPhoneSelected = index == 0;
                  });
                },
                isSelected: [isPhoneSelected, !isPhoneSelected],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _phoneEmailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: isPhoneSelected ? 'מספר טלפון' : 'כתובת מייל',
                    prefixText: isPhoneSelected ? '+079 ' : ''),
              ),
              SizedBox(height: 20),
              if (!isSend)
                ElevatedButton(
                  onPressed: _sendVerificationCode,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('שלחו לי קוד אימות'),
                ),
              if (isSend)
                Column(children: [
                  Text("שלחנו לך קוד אימות למייל"),
                  SizedBox(height: 20),
                  TextField(
                    controller: _phoneEmailTrustController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'קוד אימות',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _VerifyCode,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text('אישור'),
                  ),
                ])
            ],
          ),
        ),
      ),
    );
  }

  void _sendVerificationCode() async {
    String input = _phoneEmailController.text.trim();
    if (isPhoneSelected) {
      await _auth.verifyPhoneNumber(
        phoneNumber: input,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } else if(validateEmail(_phoneEmailController.text)){
      setState(() {
        isSend = true;
      });
      if (!(await emailService.isEmailRegistered(_phoneEmailController.text))) {
        await emailService.registerEmail(_phoneEmailController.text);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('המייל נרשם')));
      }
      await emailService.sendVerificationEmail(input);
    }
  }

  void _VerifyCode() async {
    if (emailService.code == _phoneEmailTrustController.text) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
    bool validateEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}

