import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
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
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.27,
            color: EventAppTheme.darkerText,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://media-exp1.licdn.com/dms/image/C5103AQHvImFr-w_S5A/profile-displayphoto-shrink_800_800/0/1544141617554?e=1632355200&v=beta&t=0CS8wJHW3c2J94wEWFg4EDL_xkFb_mmamtlT1eWefhk',
              ),
              radius: 52,
            ),
            SizedBox(height: 15),
            Text(
              'NAME',
              style: TextStyle(
                  fontSize: 20,
                  //fontFamily: "Courier",
                  fontWeight: FontWeight.bold),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Matric No.: ",
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text: "U1923123E",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ])),
                      const SizedBox(height: 10),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Email: ", style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text: "XIEM0011@e.ntu.edu.sg",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ])),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Remark",
                      hintText: "e.g. Vegeterin etc.",
                      prefixIcon: Icon(Icons.message),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.maxFinite,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
