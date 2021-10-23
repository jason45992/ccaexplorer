import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:ccaexplorer/login/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:provider/provider.dart'; // new
import '/src/widgets.dart'; // new
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:ccaexplorer/app_theme.dart';
import 'about_us.dart';

class Setting extends StatelessWidget {
  const Setting({
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
            "Setting",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 0.27,
              color: EventAppTheme.darkerText,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 80),
              Card(
                elevation: 2,
                shadowColor: EventAppTheme.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.info, color: EventAppTheme.grey),
                  title: Text('About Us'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shadowColor: EventAppTheme.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.password, color: EventAppTheme.grey),
                  title: Text('Password'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shadowColor: EventAppTheme.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                    leading: Icon(Icons.feedback, color: EventAppTheme.grey),
                    title: Text('Feedback'),
                    onTap: () {}),
              ),
              SizedBox(height: 350),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shadowColor: EventAppTheme.grey.withOpacity(0.4),
                      primary: EventAppTheme.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
