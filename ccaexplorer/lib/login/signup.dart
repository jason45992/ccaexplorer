import 'dart:math';

import 'package:ccaexplorer/event_details/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:ccaexplorer/authentication.dart'; // new
import '../../../main.dart';
import '../../login/login.dart';
import '../../login/admin_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  __State createState() => __State();
}

class __State extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // final void Function() startLoginFlow;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return 'Please input a valid Email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'NTU Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please re-enter password';
                        }

                        if (passwordController.text !=
                            repasswordController.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: repasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re-enter Password',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminSignUp()),
                );
                //forgot password screen
              },
              textColor: Colors.grey,
              child: Text('If you are a club Admin ...'),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.grey,
                child: Text('Submit'),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    print("successful");
                    registration();
                    return;
                  } else {
                    print("UnSuccessfull");
                  }
                },
              ),
            ),
            Container(
                child: Row(
              children: <Widget>[
                Text(''),
                FlatButton(
                  textColor: Colors.grey,
                  child: Text(
                    'Already had an account? Sign in here.',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
          ],
        ),
      ),
    );
  }

  Future registration() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        FirebaseFirestore.instance
            .collection('useracc')
            .doc(result.user!.uid)
            .set({
          'userid': result.user!.uid,
          'NTUEmail': emailController.text,
          'Name': nameController.text
        }).then((res) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignIn()),
          );
        });
      });
    } on FirebaseAuthException catch (err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(err.code),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
