import 'dart:ui';
import 'package:ccaexplorer/admin/applicant_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'admin_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCLubApplicationList extends StatefulWidget {
  final String clubId;
  AdminCLubApplicationList(this.clubId, {Key? key}) : super(key: key);

  @override
  _AdminCLubApplicationListState createState() =>
      _AdminCLubApplicationListState(this.clubId);
}

class _AdminCLubApplicationListState extends State<AdminCLubApplicationList> {
  AnimationController? animationController;
  final String clubId;
  final _controller = TextEditingController();

  String searchKey = "";
  List<CLubApplicantDetails> _clubApplicantlList = [];
  _AdminCLubApplicationListState(this.clubId);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AdminTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    getSearchBarUI(),
                    // getfunctionBar(),
                    getUserList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AdminTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 100),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Application List',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getUserList() {
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 600,
        child: ListView.separated(
            padding: EdgeInsets.only(top: 10),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                  height: 80,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Color(0xFFE6E4E3),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: 60,
                          height: 60,
                          child: _clubApplicantlList[index]
                                  .profilePicUrl
                                  .isNotEmpty
                              ? InkWell(
                                  child: Image.network(
                                      _clubApplicantlList[index].profilePicUrl),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdminApplicantProfile(
                                                _clubApplicantlList[index]),
                                      ),
                                    );
                                  },
                                )
                              : InkWell(
                                  child: Image.asset(
                                      'assets/images/userImage.png'),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdminApplicantProfile(
                                                _clubApplicantlList[index]),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.only(top: 15, left: 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${_clubApplicantlList[index].name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                  )),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Applying ${_clubApplicantlList[index].clubRole}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          height: 30,
                          width: 30,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white24,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(100.0)),
                              onTap: () {
                                showAlertDialog2(
                                    context,
                                    _clubApplicantlList[index].clubRoleid,
                                    _clubApplicantlList[index]
                                        .clubApplicationid,
                                    _clubApplicantlList[index].userid);
                              },
                              child: Icon(Icons.check_circle_rounded,
                                  color: Colors.green),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          height: 30,
                          width: 30,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white24,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(100.0)),
                              onTap: () {
                                showAlertDialog3(
                                    context,
                                    _clubApplicantlList[index]
                                        .clubApplicationid);
                              },
                              child:
                                  Icon(Icons.cancel_rounded, color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: _clubApplicantlList.length),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AdminTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: _controller,
                    onTap: () {
                      getData();
                      _controller.clear();
                    },
                    onChanged: (String txt) {
                      searchKey = txt;
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  search();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 15,
                      color: AdminTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getfunctionBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 9, left: 16, right: 16),
      child: Row(children: <Widget>[
        SizedBox(
          width: 235,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          height: 30,
          width: 60,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              onTap: () {
                print("click");
              },
              child: Icon(FontAwesomeIcons.phoneAlt, color: Colors.red),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          height: 30,
          width: 60,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              onTap: () {
                print("click");
              },
              child: Icon(FontAwesomeIcons.solidEnvelope, color: Colors.red),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> getData() async {
    FirebaseFirestore.instance
        .collection('club_application')
        .where('club_id', isEqualTo: clubId)
        .snapshots()
        .listen((data) {
      _clubApplicantlList = [];
      data.docs.forEach((applicaiton) {
        FirebaseFirestore.instance
            .collection('useracc')
            .where('userid', isEqualTo: applicaiton.get('user_id'))
            .snapshots()
            .listen((data) {
          data.docs.forEach((user) {
            FirebaseFirestore.instance
                .collection('club_role')
                .where('id', isEqualTo: applicaiton.get('club_role_id'))
                .snapshots()
                .listen((data) {
              data.docs.forEach((clubRole) {
                print(applicaiton.get('id'));
                _clubApplicantlList.add(
                  CLubApplicantDetails(
                      name: user.get('Name'),
                      clubRole: clubRole.get('position'),
                      remarks: applicaiton.get('remark'),
                      matricNum: user.get('Matric_no'),
                      email: user.get('NTUEmail'),
                      phone: user.get('phone').toString(),
                      profilePicUrl: user.get('profile_pic_id'),
                      clubRoleid: clubRole.get('id'),
                      clubApplicationid: applicaiton.get('id'),
                      userid: user.get('userid')),
                );
              });
              setState(() {});
            });
          });
        });
      });
    });
  }

  search() {
    _clubApplicantlList = _clubApplicantlList
        .where((i) =>
            i.matricNum.toLowerCase().contains(searchKey.toLowerCase()) ||
            i.name.toLowerCase().contains(searchKey.toLowerCase()))
        .toList();
    if (_clubApplicantlList.length > 0) {
      setState(() {});
    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        getData();
        _controller.clear();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No result found"),
      content: Text("Please use other keywords."),
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

  Future<void> addUserAssignRole(String clubroleid, String userid) async {
    await Firebase.initializeApp();
    final userAssignRole =
        FirebaseFirestore.instance.collection('user_member').doc();
    final refid = userAssignRole.id;
    userAssignRole
        .set({
          'user_id': userid,
          'club_role_id': clubroleid,
          'id': refid,
          'isAdmin': false,
          'club_id': clubId
        })
        .then((value) => print("Data Added"))
        .catchError((error) => print("Failed to add user: $error"));
    final clubMember =
        FirebaseFirestore.instance.collection('club_member').doc();
    final refCMid = clubMember.id;
    clubMember
        .set({'user_id': userid, 'club_id': clubId, 'id': refCMid})
        .then((value) => print("Data Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> deleteClubApplication(String clubApplicationId) async {
    await Firebase.initializeApp();
    final clubApplication =
        FirebaseFirestore.instance.collection('club_application');
    return clubApplication.doc(clubApplicationId).delete();
  }

  showAlertDialog2(BuildContext context, String clubroleid,
      String clubApplicationId, String Userid) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        addUserAssignRole(clubroleid, Userid);
        deleteClubApplication(clubApplicationId);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Confirm Approve?",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [
        cancelButton,
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

  showAlertDialog3(BuildContext context, String clubApplicationId) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        deleteClubApplication(clubApplicationId);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Confirm Reject?",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [
        cancelButton,
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
}

class CLubApplicantDetails {
  CLubApplicantDetails(
      {required this.name,
      required this.clubRole,
      required this.remarks,
      required this.matricNum,
      required this.email,
      required this.phone,
      required this.profilePicUrl,
      required this.clubRoleid,
      required this.clubApplicationid,
      required this.userid});
  final String name;
  final String clubRole;
  final String remarks;
  final String matricNum;
  final String email;
  final String phone;
  final String profilePicUrl;
  final String clubRoleid;
  final String clubApplicationid;
  final String userid;
}
