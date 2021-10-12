import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  MePage({Key? key}) : super(key: key);

  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Me Page"),
      ),
    );
  }
}
