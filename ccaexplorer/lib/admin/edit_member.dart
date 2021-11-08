import 'dart:io';

import 'package:ccaexplorer/admin/club_member_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_theme.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class EditMember extends StatefulWidget {
  final String name;
  final String imageurl;
  final String clubId;
  final String departmentname;
  final String positionname;
  final String clubmemberid;
  final bool isAdmin;
  const EditMember(this.name, this.imageurl, this.clubId, this.departmentname,
      this.positionname, this.clubmemberid, this.isAdmin,
      {Key? key})
      : super(key: key);

  @override
  _EditMemberState createState() => _EditMemberState(
      this.name,
      this.imageurl,
      this.clubId,
      this.departmentname,
      this.positionname,
      this.clubmemberid,
      this.isAdmin);
}

class _EditMemberState extends State<EditMember> {
  final String name;
  final String imageurl;
  final String clubId;
  final String departmentname;
  final String positionname;
  final String clubmemberid;
  final bool isAdmin;
  _EditMemberState(this.name, this.imageurl, this.clubId, this.departmentname,
      this.positionname, this.clubmemberid, this.isAdmin);
  String? dropdownValue;
  String? dropdownValue2;
  bool _switchValues = false;

  List<String> clubDepartmentList = [];
  List<String> clubPositionList = [];
  List<ClubDepartmentDetails> clubDepartmentDetailList = [];
  List<ClubRoleDetails> clubRoleDetailList = [];

  @override
  void initState() {
    super.initState();
    getdata();
    setState(() {
      dropdownValue = widget.departmentname;
      _switchValues = widget.isAdmin;
      init();
    });
  }

  Future<void> init() async {
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_department');
    _clubRolecollectionRef
        .where('club_id', isEqualTo: widget.clubId)
        .snapshots()
        .listen((event) {
      clubDepartmentList = [];
      event.docs.forEach((element) {
        clubDepartmentList.add(element['name']);
        clubDepartmentDetailList.add(
          ClubDepartmentDetails(
              clubId: element['club_id'],
              departmentId: element['department_id'],
              name: element['name']),
        );
        setState(() {});
      });
      clubDepartmentDetailList.forEach((element) {
        if (element.name == widget.departmentname) {
          getPostiondata(element.departmentId);
          dropdownValue2 = widget.positionname;
        }
      });
      setState(() {});
    });
  }

  Future<void> getdata() async {
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_department');
    _clubRolecollectionRef
        .where('club_id', isEqualTo: widget.clubId)
        .snapshots()
        .listen((event) {
      clubDepartmentList = [];
      event.docs.forEach((element) {
        clubDepartmentList.add(element['name']);
        clubDepartmentDetailList.add(
          ClubDepartmentDetails(
              clubId: element['club_id'],
              departmentId: element['department_id'],
              name: element['name']),
        );
        setState(() {});
      });
    });
  }

  Future<void> getPostiondata(String departmentId) async {
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_role');
    _clubRolecollectionRef
        .where('department_id', isEqualTo: departmentId)
        .snapshots()
        .listen((event) {
      clubPositionList = [];
      clubRoleDetailList = [];
      event.docs.forEach((element) {
        clubPositionList.add(element['position']);
        clubRoleDetailList.add(
          ClubRoleDetails(
              id: element['id'],
              departmentId: element['department_id'],
              position: element['position']),
        );
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                children: <Widget>[
                  photo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5),
                    child: Text(
                      'Department',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  department(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5),
                    child: Text(
                      'Position',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  position(),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ListTileSwitch(
                      value: _switchValues,
                      onChanged: (value) {
                        setState(() {
                          _switchValues = value;
                          print(_switchValues);
                        });
                      },
                      switchActiveColor: Colors.teal,
                      switchScale: 0.8,
                      switchType: SwitchType.cupertino,
                      title: const Text(
                        'Admin Access',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(32.0),
          child: RaisedButton(
            onPressed: () {
              showAlertDialog(context);
            },
            color: Colors.grey,
            textColor: Colors.white,
            child: Text('Update'),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        clubRoleDetailList.forEach((element) {
          if (element.position == dropdownValue2) {
            FirebaseFirestore.instance
                .collection('club_member')
                .doc(widget.clubmemberid)
                .set({'club_role_id': element.id, 'isAdmin': _switchValues},
                    SetOptions(merge: true));

            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemberList(widget.clubId),
              ),
            );
          }
        });
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
        "Confirm ?",
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
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: Text(
                'Edit Member',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget photo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              imageurl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 25),
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget department() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Select'),
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down_sharp),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              clubPositionList = [];
              dropdownValue2 = null;
              dropdownValue = newValue!;
            });
            clubDepartmentDetailList.forEach((element) {
              if (element.name == newValue) {
                getPostiondata(element.departmentId);
              }
            });
          },
          items:
              clubDepartmentList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget position() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Select'),
          value: dropdownValue2,
          icon: const Icon(Icons.arrow_drop_down_sharp),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue2 = newValue!;
            });
          },
          items: clubPositionList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ClubDepartmentDetails {
  ClubDepartmentDetails({
    required this.clubId,
    required this.departmentId,
    required this.name,
  });
  final String clubId;
  final String departmentId;
  final String name;
}

class ClubRoleDetails {
  ClubRoleDetails({
    required this.id,
    required this.departmentId,
    required this.position,
  });
  final String id;
  final String departmentId;
  final String position;
}
