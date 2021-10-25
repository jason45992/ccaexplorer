import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:ccaexplorer/club/club_join/club_join_form.dart';
import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ClubContact extends StatefulWidget {
  final Club club;
  ClubContact(this.club, {Key? key}) : super(key: key);

  @override
  _ClubContactState createState() => _ClubContactState(this.club);
}

class _ClubContactState extends State<ClubContact> {
  var storage = FirebaseStorage.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var clubText = "Join Club";
  var isClickable = true;

  final Club clubDetail;
  _ClubContactState(this.clubDetail);

  @override
  void initState() {
    super.initState();
    getData();
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClubJoinPage()),
                  );
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
                clubText,
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
    // for club list
    // CollectionReference _clubCollectionRef =

    FirebaseFirestore.instance
        .collection('club_application')
        .where('user_id', isEqualTo: user!.uid)
        .snapshots()
        .listen((data) {
      data.docs.forEach((element) {
        if (element.get("club_id") == clubDetail.id) {
          clubText = "Pending";
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
          clubText = "Joined";
          isClickable = false;
          setState(() {});
        }
      });
    });
  }
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
