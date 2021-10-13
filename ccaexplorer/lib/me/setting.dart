import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:provider/provider.dart'; // new
import '/src/widgets.dart'; // new
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:ccaexplorer/app_theme.dart';

class Setting extends StatelessWidget {
  const Setting({
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
          title: Text("Setting"),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                width: 500.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.grey,
                  highlightColor: Colors.blueGrey[700],
                  colorBrightness: Brightness.dark,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "About Us                                                     ",
                        ),
                        WidgetSpan(
                          child: Icon(Icons.arrow_forward_ios, size: 14),
                        ),
                      ],
                    ),
                  ),
                  splashColor: Colors.grey,
                  onPressed: () => {},
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.grey,
                  highlightColor: Colors.blueGrey[700],
                  colorBrightness: Brightness.dark,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Password                                                     ",
                        ),
                        WidgetSpan(
                          child: Icon(Icons.arrow_forward_ios, size: 14),
                        ),
                      ],
                    ),
                  ),
                  splashColor: Colors.grey,
                  onPressed: () => {},
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.grey,
                  highlightColor: Colors.blueGrey[700],
                  colorBrightness: Brightness.dark,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Feedback                                                     ",
                        ),
                        WidgetSpan(
                          child: Icon(Icons.arrow_forward_ios, size: 14),
                        ),
                      ],
                    ),
                  ),
                  splashColor: Colors.grey,
                  onPressed: () => {},
                ),
              ),
              SizedBox(height: 350),
              ElevatedButton(
                child: Text("Log Out"),
                onPressed: () {},
                //Positioned
              ),
            ],
          ),
        ));
  }
}
