import 'package:flutter/material.dart';
import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ClubJoinPage extends StatefulWidget {
  const ClubJoinPage({Key? key, required this.clubName, required this.clubid});
  final String clubid;
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
      UserDetails(fullName: "", email: "", matricNum: "", phone: '');

  String? dropdownValue;
  String? dropdownValue2;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<String> departmentlist = [];
  List<String> positionlist = [];
  List<DepartmentDetails> departmentDetaillist = [];
  List<PositionDetails> positionDetaillist = [];

  Future<void> setClubApplicationData() async {
    String clubRoleId = '';
    final clubApplication =
        FirebaseFirestore.instance.collection('club_application').doc();
    final refid = clubApplication.id;

    positionDetaillist.forEach((element) {
      if (element.name == dropdownValue2) {
        setState(() {
          clubRoleId = element.id;
          clubApplication
              .set({
                'club_id': widget.clubid,
                'club_role_id': clubRoleId,
                'user_id': user!.uid,
                'remark': '',
                'id': refid
              })
              .then((value) => print("Data Added"))
              .catchError((error) => print("Failed to add user: $error"));
        });
      }
    });
  }

  Future<void> getpostionData() async {
    String departmentid = '';
    dropdownValue2 = null;
    positionlist = [];
    positionDetaillist = [];

    if (dropdownValue != null) {
      departmentDetaillist.forEach((element) {
        if (element.name == dropdownValue) {
          setState(() {
            departmentid = element.id;
            FirebaseFirestore.instance
                .collection('club_role')
                .where('department_id', isEqualTo: departmentid)
                .snapshots()
                .listen((position) {
              position.docs.forEach((element) {
                setState(() {
                  positionlist.add(element['position']);
                  positionDetaillist.add(PositionDetails(
                      id: element['id'], name: element['position']));
                });
              });
            });
          });
        }
      });
    }
  }

  Future<void> getdepartmentData() async {
    FirebaseFirestore.instance
        .collection('club_department')
        .where('club_id', isEqualTo: widget.clubid)
        .snapshots()
        .listen((department) {
      department.docs.forEach((element) {
        setState(() {
          departmentlist.add(element['name']);
          departmentDetaillist.add(DepartmentDetails(
              id: element['department_id'], name: element['name']));
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getdepartmentData();
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
                Form(
                  key: _formKey,
                  child: DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'field required' : null,
                    hint: Text('Select'),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    elevation: 1,
                    value: dropdownValue,
                    items: departmentlist
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (String? val) {
                      setState(() {
                        if (val != null) {
                          dropdownValue = val;
                          getpostionData();
                        }
                      });
                    },
                  ),
                ),
              ]),
              const SizedBox(height: 30),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Positions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey2,
                  child: DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'field required' : null,
                    hint: Text('Select'),
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    elevation: 1,
                    value: dropdownValue2,
                    items: positionlist
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (String? val) {
                      setState(() {
                        if (val != null) {
                          dropdownValue2 = val;
                        }
                      });
                    },
                  ),
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
                      child: Container(
                        width: 290,
                        child: Row(
                          children: [
                            personalinformation(),
                            const SizedBox(width: 20),
                            personalinformationdetails()
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 100.0, horizontal: 30),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _formKey2.currentState!.validate()) {
                            setClubApplicationData();
                            showAlertDialog(context);
                          }
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
                ],
              ),
            ],
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
            phone: element.get('phone').toString());
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
  });
  final String fullName;
  final String email;
  final String matricNum;
  final String phone;
}

class DepartmentDetails {
  DepartmentDetails({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;
}

class PositionDetails {
  PositionDetails({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;
}
