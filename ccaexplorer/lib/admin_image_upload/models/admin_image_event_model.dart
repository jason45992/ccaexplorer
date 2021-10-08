import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ccaexplorer/admin_image_upload/button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

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

  AddEvent(
      this.event_title_controller,
      this.event_venue_controller,
      this.timeinput,
      this.dropdownValue,
      this.file_path,
      this.file_path2,
      this.Textcontroller);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    String downloadUrl = '';
    String downloadUrl2 = '';
    CollectionReference event = FirebaseFirestore.instance.collection('event');

    Future<void> uploadFile(String filePath) async {
      await Firebase.initializeApp();

      File file = File(filePath);
      Reference ref = FirebaseStorage.instance.ref();
      await ref.child("images/$file.jpeg").putFile(file);
      print("added to Firebase Storage");
      downloadUrl = await FirebaseStorage.instance
          .ref('images/$file.jpeg')
          .getDownloadURL();
      // print(downloadUrl);
    }

    Future<void> uploadFile2(String filePath) async {
      await Firebase.initializeApp();
      File file = File(filePath);
      Reference ref = FirebaseStorage.instance.ref();
      await ref.child("images/$file.jpeg").putFile(file);
      print("added to Firebase Storage");
      downloadUrl2 = await FirebaseStorage.instance
          .ref('images/$file.jpeg')
          .getDownloadURL();
      // print(downloadUrl2);
    }

    Future<void> addEvent() async {
      await Firebase.initializeApp();

      return event
          .add({
            'event_title': event_title_controller,
            'place': event_venue_controller,
            'datetime': timeinput,
            'club': dropdownValue,
            'cover': downloadUrl,
            'poster': downloadUrl2,
            'description': Textcontroller
          })
          .then((value) => print("Event Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return ButtonWidget(
      onClicked: () {
        addEvent();
        uploadFile(file_path);
        uploadFile2(file_path2);
      },
      text: "Publish Event",
    );
  }
}
