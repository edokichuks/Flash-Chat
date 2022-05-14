import 'package:chat/components/roundedButton.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  final _myKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextFormField(
                  //     key: _myKey,
                  validator: (val) {
                    if (val!.isEmpty) 'This place should not be empty';
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black87),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                validator: (val) {
                  if (val!.isEmpty) 'This place should not be empty';
                },
                key: _myKey,
                textAlign: TextAlign.center,
                obscureText: true,
                style: TextStyle(color: Colors.black87),

                keyboardAppearance: Brightness.dark, //only in ios
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  validator: (val) {
                    if (val.isEmpty) 'Letters should be more than 6';
                  },
                  colour: Colors.blueAccent,
                  text: 'Register',
                  on_pressed: () async {
                    setState(() {
                      showSpinner = !showSpinner;
                    });
                    // print(
                    //     'your email is $email\nAnd your password is $password');
                    try {
                      if (_myKey.currentState!.validate()) {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                            showSpinner = !showSpinner;
                          });
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
