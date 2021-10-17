import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '/admin_image_upload/models/admin_image_event_model.dart';
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
      body: Column(
        //padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://media-exp1.licdn.com/dms/image/C5103AQHvImFr-w_S5A/profile-displayphoto-shrink_800_800/0/1544141617554?e=1632355200&v=beta&t=0CS8wJHW3c2J94wEWFg4EDL_xkFb_mmamtlT1eWefhk',
              ),
              radius: 52,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'NAME',
            style: TextStyle(
                fontSize: 20,
                //fontFamily: "Courier",
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: Color(0xffb0b4b8),
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                border: Border.all(color: Color(0xffb0b4b8))),
            height: 30,
            width: 150,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white24,
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                onTap: () {
                  //edit profile page
                },
                child: Center(
                  child: Text(
                    "Contact Information",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.27,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(text: "Phone "),
            TextSpan(
              text: "88841361",
              style: TextStyle(color: Colors.grey),
            ),
          ])),
          Column(),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: Color(0xffb0b4b8),
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                border: Border.all(color: Color(0xffb0b4b8))),
            height: 30,
            width: 150,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white24,
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                onTap: () {
                  //edit profile page
                },
                child: Center(
                  child: Text(
                    "Private Information",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.27,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
    );
  }
}
