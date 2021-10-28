import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:provider/provider.dart'; // new
import '/src/widgets.dart'; // new
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:ccaexplorer/app_theme.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({
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
          "About Us",
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
            Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        'We are a group of NTU EEE students who is working on a DIP project about SmartApp "CCA EXPLORER". \nWe aim to provide a platform for NTU students to enjoy their CCA life online.',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14, height: 1.6),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
