import 'package:ccaexplorer/admin/edit_member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'admin_theme.dart';

class MemberList extends StatefulWidget {
  final String clubId;
  MemberList(this.clubId, {Key? key}) : super(key: key);

  @override
  _MemberListState createState() => _MemberListState(this.clubId);
}

class _MemberListState extends State<MemberList> {
  final String clubId;
  _MemberListState(this.clubId);

  List<ClubMemberDetails> memberList = [];

  @override
  void initState() {
    super.initState();
    getMembers();
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

  showAlertDialog(BuildContext context, String clubmemberId) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();

        deletedata(clubmemberId);
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
        "Confirm Delete?",
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
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 0),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height,
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
            Container(
              width: 280,
              child: Center(
                child: Text(
                  "Club Members",
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
                          child: memberList[index].profilePicUrl.isNotEmpty
                              ? Image.network(memberList[index].profilePicUrl)
                              : Image.asset('assets/images/userImage.png'),
                        ),
                        Container(
                          width: 110,
                          padding: const EdgeInsets.only(top: 20, left: 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${memberList[index].name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                  )),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${memberList[index].department.replaceRange(8, memberList[index].department.length, '...')}-${memberList[index].position}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Color(0xffb0b4b8),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              border: Border.all(color: Color(0xffb0b4b8))),
                          height: 30,
                          width: 60,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white24,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(100.0)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditMember(
                                        memberList[index].name,
                                        memberList[index].profilePicUrl,
                                        widget.clubId,
                                        memberList[index].department,
                                        memberList[index].position,
                                        memberList[index].clubmemberId,
                                        memberList[index].isAdmin),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Edit",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    letterSpacing: 0.27,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Color(0xffb0b4b8),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              border: Border.all(color: Color(0xffb0b4b8))),
                          height: 30,
                          width: 75,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white24,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(100.0)),
                              onTap: () {
                                showAlertDialog(
                                    context, memberList[index].clubmemberId);
                              },
                              child: Center(
                                child: Text(
                                  "Remove",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    letterSpacing: 0.27,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: memberList.length),
      ),
    );
  }

  Future<void> deletedata(String id) async {
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_member');
    _clubRolecollectionRef.doc(id).delete();
  }

  void getMembers() {
    memberList = [];
    FirebaseFirestore.instance
        .collection('club_member')
        .where('club_id', isEqualTo: clubId)
        .snapshots()
        .listen((data) {
      data.docs.forEach((clubMember) {
        FirebaseFirestore.instance
            .collection('useracc')
            .where('userid', isEqualTo: clubMember.get('user_id'))
            .snapshots()
            .listen((data) {
          data.docs.forEach((user) {
            FirebaseFirestore.instance
                .collection('club_role')
                .where('id', isEqualTo: clubMember.get('club_role_id'))
                .snapshots()
                .listen((data) {
              data.docs.forEach((clubrole) {
                FirebaseFirestore.instance
                    .collection('club_department')
                    .where('department_id',
                        isEqualTo: clubrole.get('department_id'))
                    .snapshots()
                    .listen((data) {
                  data.docs.forEach((department) {
                    memberList.add(
                      ClubMemberDetails(
                          name: user.get('Name'),
                          position: clubrole.get('position'),
                          department: department.get('name'),
                          email: user.get('NTUEmail'),
                          phone: user.get('phone').toString(),
                          profilePicUrl: user.get('profile_pic_id'),
                          clubmemberId: clubMember.get('id'),
                          isAdmin: clubMember.get('isAdmin')),
                    );
                  });
                  setState(() {});
                });
              });
            });
          });
        });
      });
    });
  }
}

class ClubMemberDetails {
  ClubMemberDetails({
    required this.name,
    required this.position,
    required this.department,
    required this.email,
    required this.phone,
    required this.profilePicUrl,
    required this.clubmemberId,
    required this.isAdmin,
  });
  final String name;
  final String position;
  final String department;
  final String email;
  final String phone;
  final String profilePicUrl;
  final String clubmemberId;
  final bool isAdmin;
}
