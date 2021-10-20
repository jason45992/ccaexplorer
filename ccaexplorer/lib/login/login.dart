import 'package:ccaexplorer/home_page.dart';
import 'package:flutter/material.dart';
import '../../login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: SignIn(),
  ));
}

class SignIn extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // final void Function() startLoginFlow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/signIn.JPG"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              height: 375,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "CCA \nExplorer",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 50,
                        letterSpacing: 0.27,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NTU Email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(
                    top: 30, left: 11, right: 11, bottom: 11),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Sign In",
                          style: const TextStyle(
                              fontSize: 30,
                              color: Color(0xFF434852),
                              fontWeight: FontWeight.bold)),
                      Container(
                        height: 70,
                        child: MaterialButton(
                            color: Color(0xFF434852),
                            shape: CircleBorder(),
                            onPressed: () {
                              login();
                            },
                            child: Icon(FontAwesomeIcons.arrowRight,
                                color: Colors.white)),
                      ),
                    ])),
            Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                          //signup screen
                        },
                        child: const Text('Sign Up',
                            style: const TextStyle(color: Color(0xFF434852)))),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondRoute()),
                        );
                        //forgot password screen
                      },
                      child: const Text('Forgot Password',
                          style: const TextStyle(color: Color(0xFF434852))),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
      // print(e.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.code),
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
