import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../login/login.dart';
import '../../login/admin_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  __State createState() => __State();
}

class __State extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController matricnumController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // final void Function() startLoginFlow;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    matricnumController.dispose();
    phonenumController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/signUp.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
            ),
            Container(
              height: 150,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Create \nAccount",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        letterSpacing: 0.27,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    height: 75,
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
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@e.ntu.edu.sg")
                            .hasMatch(value)) {
                          return 'Please input a valid NTU Email';
                        }
                        return null;
                      },
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 3),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'NTU Email',
                        labelStyle: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 75,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 3),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 75,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Matriculation Number';
                        }
                        return null;
                      },
                      controller: matricnumController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 3),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Matriculation Number',
                        labelStyle: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 75,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Phone Number';
                        }
                        return null;
                      },
                      controller: phonenumController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 3),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        labelStyle: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 75,
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
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 3),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 75,
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
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 3),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Re-enter Password',
                        labelStyle: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(
                    top: 30, left: 11, right: 11, bottom: 11),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Sign Up",
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Container(
                        height: 70,
                        child: MaterialButton(
                            color: Color(0xFF434852),
                            shape: CircleBorder(),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                print("successful");
                                registration();
                                return;
                              } else {
                                print("UnSuccessfull");
                              }
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
                      child: Text('Sign in',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              decoration: TextDecoration.underline)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                        //signup screen
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminSignUp()),
                        );
                        //forgot password screen
                      },
                      child: Text('Club Admin?',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF434852),
                              decoration: TextDecoration.underline)),
                    ),
                  ],
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
          .then((result) async {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Email Verification '),
                  content:
                      Text('An verification email had sent to your mail box'),
                  actions: [
                    TextButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                    )
                  ],
                );
              });
        }

        FirebaseFirestore.instance
            .collection('useracc')
            .doc(result.user!.uid)
            .set({
          'userid': result.user!.uid,
          'NTUEmail': emailController.text,
          'Name': nameController.text,
          'phone': phonenumController.text,
          'Matric_no': matricnumController.text,
          'is_admin': false
        }).then((res) {
          print('data added');
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
