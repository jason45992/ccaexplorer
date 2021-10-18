import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:provider/provider.dart'; // new
import '/src/widgets.dart'; // new
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:ccaexplorer/app_theme.dart';

class MemberList extends StatelessWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        title: const Text('Chinese Society'),
      ),
      body: ListView(
        children: <Widget>[
          // Image.asset('assets/codelab.png'),
          const SizedBox(height: 15),
          Text(
            '  Club Member List',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          // Modify from here

          new Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        " Liu Zinan\nPresident",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 120),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        " Liu Zinan\nPresident",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 120),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        " Liu Zinan\nPresident",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 120),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        " Liu Zinan\nPresident",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 120),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        " Liu Zinan\nPresident",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 120),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        size: 35.0,
                      ),
                      tooltip: 'press',
                      onPressed: () {
                        print("press");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
