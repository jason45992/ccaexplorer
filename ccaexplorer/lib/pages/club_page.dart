import 'package:flutter/material.dart';

class ClubPage extends StatefulWidget {
  ClubPage({Key? key}) : super(key: key);

  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Club Page"),
      ),
    );
  }
}
