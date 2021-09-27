import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget {
  TimetablePage({Key? key}) : super(key: key);

  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timetable Page"),
      ),
    );
  }
}
