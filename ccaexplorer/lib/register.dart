import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:provider/provider.dart'; // new
import 'src/authentication.dart'; // new
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:ccaexplorer/app_theme.dart';
import 'src/widgets.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        title: const Text('Event Title'),
      ),
      body: ListView(
        children: <Widget>[
          // Image.asset('assets/codelab.png'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, 'Time'),
          const Paragraph(
            '  XXXXXXXXXXX',
          ),
          const IconAndDetail(Icons.location_city, 'Place'),
          const Paragraph(
            '  XXXXXXXXXXXX\n  XXXXXX\n  XXXXX',
          ),

          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),

          // Modify from here

          new Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0)),
            child: Text(
                "Name: XXXX\nMatric Number: XXXXXXXXX\nEmail:XXXXXX@e.ntu.edu.sg\nMobile Phone: XXXXXXXX",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                  height: 1.2,
                  fontFamily: "Courier",
                )),
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
          // To here.

          ElevatedButton(
            child: Text("Confirm"),
            onPressed: () {},
            //Positioned
          ),
        ],
      ),
    );
  }
}
