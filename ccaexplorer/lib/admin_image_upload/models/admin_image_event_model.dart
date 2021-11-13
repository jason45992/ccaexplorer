import 'dart:async';

import 'package:ccaexplorer/admin/published_events.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:path/path.dart';

class AddEvent extends StatelessWidget {
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  // ignore: non_constant_identifier_names
  final String event_title_controller;
  // ignore: non_constant_identifier_names
  final String event_venue_controller;
  // final String event_description_controller;
  final String timeinput;
  final String? dropdownValue;
  // ignore: non_constant_identifier_names
  final String file_path;
  // ignore: non_constant_identifier_names
  final String file_path2;
  // ignore: non_constant_identifier_names
  final String Textcontroller;
  final String clubname;

  AddEvent(
      this.event_title_controller,
      this.event_venue_controller,
      this.timeinput,
      this.dropdownValue,
      this.file_path,
      this.file_path2,
      this.Textcontroller,
      this.clubname);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    String downloadUrl = '';
    String downloadUrl2 = '';
    final event = FirebaseFirestore.instance.collection('event').doc();

    Future<void> uploadFile(String filePath) async {
      await Firebase.initializeApp();

      File file = File(filePath);
      String fileName = basename(filePath);
      Reference ref = FirebaseStorage.instance.ref();
      await ref.child("Coverimages/$fileName.jpeg").putFile(file);
      print("added to Firebase Storage");
      downloadUrl = await FirebaseStorage.instance
          .ref('Coverimages/$fileName.jpeg')
          .getDownloadURL();
      print(downloadUrl);
    }

    Future<void> addEvent() async {
      await Firebase.initializeApp();
      final refid = event.id;
      return event.set({
        'event_title': event_title_controller,
        'place': event_venue_controller,
        'datetime': timeinput,
        'club': dropdownValue,
        'cover': downloadUrl,
        'poster': downloadUrl2,
        'description': Textcontroller,
        'eventid': refid
      }).then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdminPublishedEvents(clubname)),
        );
      }).catchError((error) => print("Failed to add user: $error"));
    }

    Future<void> uploadFile2(String filePath1, String filePath) async {
      await Firebase.initializeApp();
      uploadFile(filePath1);
      File file = File(filePath);
      String fileName = basename(filePath);
      Reference ref = FirebaseStorage.instance.ref();
      await ref.child("Posterimages/$fileName.jpeg").putFile(file);
      print("added to Firebase Storage");
      downloadUrl2 = await FirebaseStorage.instance
          .ref('Posterimages/$fileName.jpeg')
          .getDownloadURL();
      print(downloadUrl2);
      Future.delayed(const Duration(milliseconds: 1000), () {
        addEvent();
      });
    }

    showAlertDialog(
      BuildContext context,
    ) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("Yes"),
        onPressed: () {
          uploadFile2(file_path, file_path2);
        },
      );
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        elevation: 2,
        buttonPadding: EdgeInsets.symmetric(vertical: 20),
        content: Text(
          "Confirm Add?",
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        actions: [
          cancelButton,
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return ElevatedButton(
      onPressed: () async {
        showAlertDialog(context);
      },
      child: Text("Publish Event"),
    );
  }
}

class UpdateEvent extends StatelessWidget {
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  // ignore: non_constant_identifier_names
  final String event_title_controller;
  // ignore: non_constant_identifier_names
  final String event_venue_controller;
  // final String event_description_controller;
  final String timeinput;
  final String? dropdownValue;
  // ignore: non_constant_identifier_names
  final String file_path;
  // ignore: non_constant_identifier_names
  final String file_path2;
  // ignore: non_constant_identifier_names
  final String Textcontroller;
  final String eventid;
  final String clubname;

  UpdateEvent(
      this.event_title_controller,
      this.event_venue_controller,
      this.timeinput,
      this.dropdownValue,
      this.file_path,
      this.file_path2,
      this.Textcontroller,
      this.eventid,
      this.clubname);

  @override
  Widget build(BuildContext context) {
    String downloadUrl = '';
    String downloadUrl2 = '';

    Future<void> uploadFile(String filePath) async {
      await Firebase.initializeApp();

      File file = File(filePath);
      String fileName = basename(filePath);
      Reference ref = FirebaseStorage.instance.ref();
      await ref.child("coverimages/$fileName.jpeg").putFile(file);
      print("added to Firebase Storage");
      downloadUrl = await FirebaseStorage.instance
          .ref('coverimages/$fileName.jpeg')
          .getDownloadURL();
      // print(downloadUrl);
    }

    Future<void> uploadFile2(String filePath) async {
      await Firebase.initializeApp();
      File file = File(filePath);
      String fileName = basename(filePath);
      Reference ref = FirebaseStorage.instance.ref();
      await ref.child("posterimages/$fileName.jpeg").putFile(file);
      print("added to Firebase Storage");
      downloadUrl2 = await FirebaseStorage.instance
          .ref('posterimages/$fileName.jpeg')
          .getDownloadURL();
      // print(downloadUrl2);
    }

    Future<void> updateEvent() async {
      await Firebase.initializeApp();
      if (downloadUrl != '' && downloadUrl2 == '') {
        return FirebaseFirestore.instance
            .collection('event')
            .doc(eventid)
            .update({
              'event_title': event_title_controller,
              'place': event_venue_controller,
              'datetime': timeinput,
              'club': dropdownValue,
              'cover': downloadUrl,
              'description': Textcontroller,
            })
            .then((value) => print("Event Updated"))
            .catchError((error) => print("Failed to add user: $error"));
      }
      if (downloadUrl == '' && downloadUrl2 != '') {
        return FirebaseFirestore.instance
            .collection('event')
            .doc(eventid)
            .update({
              'event_title': event_title_controller,
              'place': event_venue_controller,
              'datetime': timeinput,
              'club': dropdownValue,
              'poster': downloadUrl2,
              'description': Textcontroller,
            })
            .then((value) => print("Event Updated"))
            .catchError((error) => print("Failed to add user: $error"));
      }
      if (downloadUrl2 != '' && downloadUrl != '') {
        return FirebaseFirestore.instance
            .collection('event')
            .doc(eventid)
            .update({
              'event_title': event_title_controller,
              'place': event_venue_controller,
              'datetime': timeinput,
              'club': dropdownValue,
              'cover': downloadUrl,
              'poster': downloadUrl2,
              'description': Textcontroller,
            })
            .then((value) => print("Event Updated"))
            .catchError((error) => print("Failed to add user: $error"));
      } else {
        return FirebaseFirestore.instance
            .collection('event')
            .doc(eventid)
            .update({
              'event_title': event_title_controller,
              'place': event_venue_controller,
              'datetime': timeinput,
              'club': dropdownValue,
              'description': Textcontroller,
            })
            .then((value) => print("Event Updated"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    }

    showAlertDialog(
      BuildContext context,
    ) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("Yes"),
        onPressed: () {
          if (file_path != '') {
            uploadFile(file_path);
          }
          if (file_path2 != '') {
            uploadFile2(file_path2);
          }
          Future.delayed(const Duration(milliseconds: 1000), () {
            updateEvent();
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminPublishedEvents(clubname)),
              );
            });
          });
        },
      );
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        elevation: 2,
        buttonPadding: EdgeInsets.symmetric(vertical: 20),
        content: Text(
          "Confirm Update?",
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        actions: [
          cancelButton,
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    showAlertDialog2(
      BuildContext context,
    ) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("Ok"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        elevation: 2,
        buttonPadding: EdgeInsets.symmetric(vertical: 20),
        content: Text(
          "Organiser Cannot be Null!!!",
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return ElevatedButton(
      child: Text("Update Event"),
      onPressed: () {
        if (dropdownValue == null) {
          showAlertDialog2(context);
        } else {
          showAlertDialog(context);
        }
      },
    );
  }
}
