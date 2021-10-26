import 'package:flutter/material.dart';
import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ClubJoinPage extends StatefulWidget {
  const ClubJoinPage({Key? key, required this.clubName});

  final String clubName;

  @override
  State<StatefulWidget> createState() {
    return ClubJoinPageState();
  }
}

class ClubJoinPageState extends State<ClubJoinPage> {
  var storage = FirebaseStorage.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserDetails currentUser =
      UserDetails(fullName: "", email: "", matricNum: "", phone: 0);

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
          'Join Club',
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
                  'Club Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.clubName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                  ),
                )
              ]),
              const SizedBox(height: 30),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Departments',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButton(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  elevation: 1,
                  value: selected1,
                  items: Department.map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (String? val) {
                    setState(() {
                      if (val != null) {
                        selected1 = val;
                      }
                    });
                  },
                ),
              ]),
              const SizedBox(height: 30),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Positions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  elevation: 1,
                  value: selected2,
                  items: Position.map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (String? val) {
                    setState(() {
                      if (val != null) {
                        selected2 = val;
                      }
                    });
                  },
                ),
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Row(
                            children: [
                              personalinformation(),
                              const SizedBox(width: 40),
                              personalinformationdetails()
                            ],
                          ),
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
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 30),
        child: SizedBox(
          width: double.maxFinite,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              showAlertDialog(context);
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
            phone: element.get('phone'));
        setState(() {});
      });
    });
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
        "Application submitted successfully.",
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
            fontSize: 16,
            fontWeight: FontWeight.w100,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Matric No.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w100,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Email',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w100,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Contact No.',
          style: TextStyle(
            fontSize: 16,
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
            fontSize: 16,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currentUser.matricNum,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currentUser.email,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currentUser.phone.toString(),
          style: TextStyle(
            fontSize: 16,
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
  });
  final String fullName;
  final String email;
  final String matricNum;
  final int phone;
}
