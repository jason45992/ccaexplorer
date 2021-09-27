import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  EventPage({Key? key}) : super(key: key);

  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Page"),
      ),
    );
  }
}
