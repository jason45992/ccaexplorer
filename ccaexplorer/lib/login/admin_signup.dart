import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AdminSignUp extends StatefulWidget {
  @override
  a_State createState() => a_State();
}

class a_State extends State<AdminSignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController clubverficationController = TextEditingController();
  TextEditingController matricnumController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isInvalidAsyncCode = false;
  bool _isInAsyncCall = false;
  Color color = Colors.black;

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
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/signUpAdmin.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  color: EventAppTheme.darkerText,
                  icon: new Icon(Icons.arrow_back_ios),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
              ),
              Container(
                height: 100,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Welcome \nAdmin",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
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
                          return null;
                        },
                        controller: emailController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 3),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'NTU Email',
                          labelStyle: new TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 3),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          labelStyle: new TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 3),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Matriculation Number',
                          labelStyle: new TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 3),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                          labelStyle: new TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 3),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          labelStyle: new TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 3),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Re-enter Password',
                          labelStyle: new TextStyle(color: Colors.black),
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
                            return 'Please enter verification code';
                          }

                          if (_isInvalidAsyncCode) {
                            return "Invalid Verification Code";
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: clubverficationController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 3),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Club Verification Code',
                          labelStyle: new TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      top: 50, left: 11, right: 11, bottom: 11),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Sign Up",
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
                                submit();
                              },
                              child: Icon(FontAwesomeIcons.arrowRight,
                                  color: Colors.white)),
                        ),
                      ])),
            ],
          ),
        ),
      ),
    ));
  }

  void submit() {
    setState(() {
      _isInAsyncCall = true;
    });
    var verficationcodelist = [];
    FirebaseFirestore.instance
        .collection('verificationcode')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        verficationcodelist.add(doc['code']);
      });
      print(verficationcodelist);
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isInAsyncCall = false;
      });
      if (!verficationcodelist.contains(clubverficationController.text)) {
        print(clubverficationController.text);
        _isInvalidAsyncCode = true;
      } else {
        _isInvalidAsyncCode = false;
      }
      if (_formkey.currentState!.validate()) {
        print("successful");
        registration();
        return;
      } else {
        print("UnSuccessfull");
      }
    });
  }

  Future registration() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        FirebaseFirestore.instance
            .collection('adminacc')
            .doc(result.user!.uid)
            .set({
          'userid': result.user!.uid,
          'NTUEmail': emailController.text,
          'phone_number': phonenumController.text,
          'matriculation_number': matricnumController.text,
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
