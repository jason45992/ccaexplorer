import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication.dart';
import '../home_event_list/models/user_data_model.dart';

class RedeemConfirmationScreen extends StatelessWidget {
  final List<String> entries = <String>[
    'Events',
    'Club Management',
    'Application List'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.85),
        body: Column(children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top + 100,
          ),
          SizedBox(
            height: 400,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                    height: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.grey,
                      child: Center(
                          child: Text(
                        '${entries[index]}',
                      )),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: entries.length),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.close, color: Colors.white),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              primary: Colors.blue, // <-- Button color
              onPrimary: Colors.red, // <-- Splash color
            ),
          )
        ]));
  }
}
