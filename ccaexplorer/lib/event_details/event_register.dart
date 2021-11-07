import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EventRegisterPage extends StatefulWidget {
  const EventRegisterPage(
      {Key? key,
      required this.eventName,
      required this.eventDateTime,
      required this.eventVenue,
      required this.eventid});
  final String eventName;
  final String eventDateTime;
  final String eventVenue;
  final String eventid;

  State<StatefulWidget> createState() {
    return EventRegisterPageState();
  }
}

class EventRegisterPageState extends State<EventRegisterPage> {
  var storage = FirebaseStorage.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserDetails currentUser = UserDetails(
      fullName: "", email: "", matricNum: "", phone: '0', userid: '');

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
        backgroundColor: Colors.white,
        title: Text(
          'Register Event',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.27,
            color: EventAppTheme.darkerText,
          ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: EventAppTheme.darkerText,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Event',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.eventName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                  ),
                )
              ]),
              const SizedBox(height: 30),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.eventDateTime,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                  ),
                )
              ]),
              const SizedBox(height: 30),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Venue',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.eventName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                  ),
                )
              ]),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Container(
                        width: 270,
                        child: Row(
                          children: [
                            personalinformation(),
                            const SizedBox(width: 30),
                            personalinformationdetails()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 30),
        child: SizedBox(
          width: double.maxFinite,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              eventregistration();
            },
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: EventAppTheme.grey.withOpacity(0.4),
              primary: EventAppTheme.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    FirebaseFirestore.instance
        .collection('useracc')
        .where('userid', isEqualTo: user!.uid)
        .snapshots()
        .listen((data) {
      data.docs.forEach((element) {
        currentUser = UserDetails(
          fullName: element.get('Name'),
          email: element.get('NTUEmail'),
          matricNum: element.get('Matric_no'),
          phone: element.get('phone').toString(),
          userid: element.get('userid'),
        );

        setState(() {});
      });
    });
  }

  Future eventregistration() async {
    await Firebase.initializeApp();
    final eventApplication =
        FirebaseFirestore.instance.collection('event_application').doc();
    final refid = eventApplication.id;
    eventApplication
        .set({
          'event_id': widget.eventid,
          'user_id': currentUser.userid,
          'remark': '',
          'id': refid
        })
        .then((value) => showAlertDialog(context))
        .catchError((error) => print("Failed to add user: $error"));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Event successfully registered.",
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

  var selected1 = 'Student Development';
  final Department = [
    'Student Development',
    'Branding',
    'Business',
    'Studentlife',
    'Ops Support',
    'Relations',
    'Finance'
  ];
  var selected2 = 'Group Leader';
  final Position = ['Group Leader', 'Group Member'];
  Widget personalinformation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Matric No.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Email',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Contact No.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget personalinformationdetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentUser.fullName,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currentUser.matricNum,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currentUser.email,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currentUser.phone,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

class UserDetails {
  UserDetails({
    required this.fullName,
    required this.email,
    required this.matricNum,
    required this.phone,
    required this.userid,
  });
  final String fullName;
  final String email;
  final String matricNum;
  final String phone;
  final String userid;
}
