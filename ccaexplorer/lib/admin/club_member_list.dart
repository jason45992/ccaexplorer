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
                  "club Members",
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
                                  '${memberList[index].matricNum}',
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => AdminRegistrationList(
                                //         _eventDetailList[index]),
                                //   ),
                                // );
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => AdminEditEventForm(
                                //         _eventDetailList[index].club,
                                //         _eventDetailList[index].eventTitle,
                                //         _eventDetailList[index].datetime,
                                //         _eventDetailList[index].place,
                                //         _eventDetailList[index].description,
                                //         _eventDetailList[index].id,
                                //         _eventDetailList[index].cover,
                                //         _eventDetailList[index].poster),
                                //   ),
                                // );
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

  getMembers() {
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
            memberList.add(ClubMemberDetails(
                name: user.get('Name'),
                matricNum: user.get('Matric_no'),
                email: user.get('NTUEmail'),
                phone: user.get('phone').toString(),
                profilePicUrl: user.get('profile_pic_id')));
          });
          setState(() {});
        });
      });
    });
  }
}

class ClubMemberDetails {
  ClubMemberDetails(
      {required this.name,
      required this.matricNum,
      required this.email,
      required this.phone,
      required this.profilePicUrl});
  final String name;
  final String matricNum;
  final String email;
  final String phone;
  final String profilePicUrl;
}
