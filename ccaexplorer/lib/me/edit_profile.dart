import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:provider/provider.dart'; // new

import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:ccaexplorer/app_theme.dart';
import '/src/widgets.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        title: Text("Personal Profile"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://media-exp1.licdn.com/dms/image/C5103AQHvImFr-w_S5A/profile-displayphoto-shrink_800_800/0/1544141617554?e=1632355200&v=beta&t=0CS8wJHW3c2J94wEWFg4EDL_xkFb_mmamtlT1eWefhk',
              ),
              radius: 52,
            ),
            SizedBox(height: 10),
            Text(
              'NAME',
              style: TextStyle(
                  fontSize: 20,
                  //fontFamily: "Courier",
                  fontWeight: FontWeight.bold),
            ),
            Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Remark",
                    hintText: "e.g. Vegeterin etc.",
                    prefixIcon: Icon(Icons.message),
                  ),
                ),
              ],
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: "Matric No.: "),
              TextSpan(
                text: "U1923123E",
                style: TextStyle(color: Colors.grey),
              ),
            ])),
            Text.rich(TextSpan(children: [
              TextSpan(text: "Email: "),
              TextSpan(
                text: "XIEM0011@e.ntu.edu.sg",
                style: TextStyle(color: Colors.grey),
              ),
            ])),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {},
              //Positioned
            ),
          ],
        ),
      ),
    );
  }
}
