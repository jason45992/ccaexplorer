import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:ccaexplorer/me/contact_us.dart';
import 'package:ccaexplorer/me/edit_profile.dart';
import 'package:ccaexplorer/me/favourates.dart';
import 'package:ccaexplorer/me/setting.dart';
import 'package:ccaexplorer/me/contact_us.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'admin_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/admin/published_events.dart';

class EditProfile extends StatefulWidget {
  EditProfile();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var storage = FirebaseStorage.instance;
  List<ClubDetails> cLubList = [];
  List<CLubLogoDetails> cLubLogoList = [];
  List<CLubMemberDetails> cLubMemberList = [];
  User? user = FirebaseAuth.instance.currentUser;
  String username = '';
  String matricnum = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: new IconButton(
          color: EventAppTheme.darkerText,
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.27,
            color: EventAppTheme.darkerText,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                  // border: Border.all(style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ]),
              width: 80,
              height: 80,
              child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/images/userImage.png'),
                  backgroundColor: Colors.transparent),
            ),
            SizedBox(height: 15),
            Text(
              username,
              style: TextStyle(
                  fontSize: 20,
                  //fontFamily: "Courier",
                  fontWeight: FontWeight.bold),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Matric No.: ",
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text: matricnum,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ])),
                      const SizedBox(height: 10),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Email: ", style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text: email,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ])),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Remark",
                      hintText: "e.g. Vegeterin etc.",
                      prefixIcon: Icon(Icons.message),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.maxFinite,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: EventAppTheme.grey.withOpacity(0.4),
                    primary: EventAppTheme.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    // for club list
    CollectionReference _clubCollectionRef =
        FirebaseFirestore.instance.collection('club');
    // Get docs from collection reference
    QuerySnapshot clubListQuerySnapshot = await _clubCollectionRef.get();
    // Get data from docs and convert map to List
    clubListQuerySnapshot.docs.forEach((document) {
      cLubList.add(
        ClubDetails(
          category: document.get('category'),
          description: document.get('description'),
          id: document.get('id'),
          invitationCode: '',
          logoId: document.get('logo_id'),
          name: document.get('name'),
          logoUrl: '',
        ),
      );
    });

    // for club logo list
    CollectionReference _fileCollectionRef =
        FirebaseFirestore.instance.collection('file');
    // Get docs from collection reference
    QuerySnapshot clubLogoQuerySnapshot = await _fileCollectionRef.get();
    clubLogoQuerySnapshot.docs.forEach((element) {
      cLubLogoList
          .add(CLubLogoDetails(id: element.get('id'), url: element.get('url')));
    });
    cLubList.forEach((clubDetail) {
      cLubLogoList.forEach((logoDetail) {
        if (logoDetail.id == clubDetail.logoId) {
          clubDetail.logoUrl = logoDetail.url;
        }
      });
    });

    // for filter out myclub
    CollectionReference _clubMemberCollectionRef =
        FirebaseFirestore.instance.collection('club_member');
    // Get docs from collection reference
    QuerySnapshot clubMemberLogoQuerySnapshot =
        await _clubMemberCollectionRef.get();
    clubMemberLogoQuerySnapshot.docs.forEach((element) {
      cLubMemberList.add(CLubMemberDetails(
          clubId: element.get('club_id'), userId: element.get('user_id')));
    });
    cLubMemberList = cLubMemberList
        .where((clubMemberDetail) => clubMemberDetail.userId == user!.uid)
        .toList();
    List<ClubDetails> tempCLubList = [];
    cLubList.forEach((x) {
      cLubMemberList.forEach((y) {
        if (y.clubId == x.id) {
          tempCLubList.add(x);
        }
      });
    });
    cLubList = tempCLubList;

    //for user
    CollectionReference _userCollectionRef =
        FirebaseFirestore.instance.collection('useracc');
    QuerySnapshot userQuerySnapshot =
        await _userCollectionRef.where('userid', isEqualTo: user!.uid).get();
    username = userQuerySnapshot.docs.first.get('Name');
    matricnum = userQuerySnapshot.docs.first.get('Matric_no');
    email = userQuerySnapshot.docs.first.get('NTUEmail');

    setState(() {});
  }
}

class ClubDetails {
  ClubDetails(
      {required this.category,
      required this.description,
      required this.id,
      required this.invitationCode,
      required this.logoId,
      required this.name,
      required this.logoUrl});
  final String category;
  final String description;
  final String id;
  final String invitationCode;
  final String logoId;
  final String name;
  String logoUrl;

  @override
  String toString() {
    return 'name: ' + name + ' logoUrl: ' + logoUrl;
  }
}

class CLubLogoDetails {
  CLubLogoDetails({required this.id, required this.url});
  final String id;
  final String url;
}

class CLubMemberDetails {
  CLubMemberDetails({required this.clubId, required this.userId});
  final String clubId;
  final String userId;
}
