import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:ccaexplorer/club/club_join/club_join_form.dart';
import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:ccaexplorer/me/me_home.dart';
import 'package:ccaexplorer/me/member_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ClubContact extends StatefulWidget {
  final Club club;
  final List<CLubMemberDetails> cLubMemberList;
  ClubContact(this.club, this.cLubMemberList, {Key? key}) : super(key: key);

  @override
  _ClubContactState createState() =>
      _ClubContactState(this.club, this.cLubMemberList);
}

class _ClubContactState extends State<ClubContact> {
  var storage = FirebaseStorage.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var buttonText = "Join Club";
  var isClickable = true;
  List<MemberDetails> memberList = [];

  final Club clubDetail;
  final List<CLubMemberDetails> cLubMemberList;
  _ClubContactState(this.clubDetail, this.cLubMemberList);

  @override
  void initState() {
    super.initState();
    getData();
    getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.maxFinite,
            child: Text(
              clubDetail.contact,
              // "abc",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: double.maxFinite,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (isClickable) {
                  if (clubDetail.isMember) {
                    //club member list
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MemberList(clubDetail.name, memberList)),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClubJoinPage(
                                clubName: clubDetail.name,
                                clubid: clubDetail.id,
                              )),
                    );
                  }
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
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    if (this.clubDetail.isMember) {
      buttonText = "Member List";
      isClickable = true;
    } else {
      FirebaseFirestore.instance
          .collection('club_application')
          .where('user_id', isEqualTo: user!.uid)
          .snapshots()
          .listen((data) {
        data.docs.forEach((element) {
          if (element.get("club_id") == clubDetail.id) {
            buttonText = "Pending";
            isClickable = false;
            setState(() {});
          }
        });
      });

      FirebaseFirestore.instance
          .collection('club_member')
          .where('user_id', isEqualTo: user!.uid)
          .snapshots()
          .listen((data) {
        data.docs.forEach((element) {
          if (element.get("club_id") == clubDetail.id) {
            buttonText = "Joined";
            isClickable = false;
            setState(() {});
          }
        });
      });
    }
  }

  getMembers() {
    List<CLubMemberDetails> cLubMembers =
        cLubMemberList.where((info) => info.clubId == clubDetail.id).toList();
    memberList = [];
    cLubMembers.forEach((member) {
      FirebaseFirestore.instance
          .collection('useracc')
          .where('userid', isEqualTo: member.userId)
          .snapshots()
          .listen((data) {
        data.docs.forEach((user) {
          memberList.add(MemberDetails(
              name: user.get('Name'),
              matricNum: user.get('Matric_no'),
              email: user.get('NTUEmail'),
              phone: user.get('phone').toString(),
              profilePicUrl: user.get('profile_pic_id')));
        });
        setState(() {});
      });
    });
  }
}

class MemberDetails {
  MemberDetails(
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

// class CLubMemberDetails {
//   CLubMemberDetails({required this.clubId, required this.userId});
//   final String clubId;
//   final String userId;
// }

// class CLubApplicationDetails {
//   CLubApplicationDetails({required this.clubId, required this.userId});
//   final String clubId;
//   final String userId;
// }
