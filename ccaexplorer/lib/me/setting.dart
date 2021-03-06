import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:ccaexplorer/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:provider/provider.dart'; // new
import '/src/widgets.dart'; // new
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:ccaexplorer/app_theme.dart';
import 'about_us.dart';

class Setting extends StatelessWidget {
  const Setting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading: new IconButton(
            color: EventAppTheme.darkerText,
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () => {Navigator.of(context).pop()},
          ),
          title: Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 0.27,
              color: EventAppTheme.darkerText,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 80),
              Card(
                elevation: 2,
                shadowColor: EventAppTheme.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.info, color: EventAppTheme.grey),
                  title: Text('About Us'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shadowColor: EventAppTheme.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                    leading: Icon(Icons.password, color: EventAppTheme.grey),
                    title: Text('Password'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagePassWord()),
                      );
                    }),
              ),
              Card(
                elevation: 2,
                shadowColor: EventAppTheme.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                    leading: Icon(Icons.feedback, color: EventAppTheme.grey),
                    title: Text('Feedback'),
                    onTap: () {}),
              ),
              SizedBox(height: 350),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                          (route) => false);
                      await FirebaseAuth.instance.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shadowColor: EventAppTheme.grey.withOpacity(0.4),
                      primary: EventAppTheme.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class ManagePassWord extends StatefulWidget {
  const ManagePassWord({Key? key}) : super(key: key);

  @override
  _ManagePassWordState createState() => _ManagePassWordState();
}

class _ManagePassWordState extends State<ManagePassWord> {
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController reenternewpasswordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: new IconButton(
          color: EventAppTheme.darkerText,
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        title: Text(
          "Change Password",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.27,
            color: EventAppTheme.darkerText,
          ),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is compulsory!';
                  }
                  return null;
                },
                obscureText: true,
                controller: oldpasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Please enter your old password',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is compulsory!';
                  }
                  return null;
                },
                obscureText: true,
                controller: newpasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Please enter your new password',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please re-enter your new password';
                  }

                  if (newpasswordController.text !=
                      reenternewpasswordController.text) {
                    return "Password does not match with your new password";
                  }
                  return null;
                },
                obscureText: true,
                controller: reenternewpasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Please re-Enter your new password',
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 60),
        child: SizedBox(
          width: double.maxFinite,
          height: 44,
          child: ElevatedButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                _changePassword(
                    oldpasswordController.text, newpasswordController.text);
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: EventAppTheme.grey.withOpacity(0.4),
              primary: EventAppTheme.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _changePassword(String currentPassword, String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user!.email;
    if (email != null) {
      AuthCredential cred =
          EmailAuthProvider.credential(email: email, password: currentPassword);
      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Success'),
                  content: Text('Your Password had changed sucessfully'),
                  actions: [
                    TextButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }).catchError((error) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(error.code),
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
        });
      }).catchError((err) {
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
      });
    }
  }
}
