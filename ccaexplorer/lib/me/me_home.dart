import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'admin_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeHome extends StatefulWidget {
  MeHome();

  @override
  _MeHomeState createState() => _MeHomeState();
}

class _MeHomeState extends State<MeHome> {
  var storage = FirebaseStorage.instance;
  List<ClubDetails> cLubList = [];
  List<CLubLogoDetails> cLubLogoList = [];
  List<CLubMemberDetails> cLubMemberList = [];
  User? user = FirebaseAuth.instance.currentUser;
  String username = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xFF3A5160),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/profile.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                getAppBarUI(),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width - 200),
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color(0xFF3A5160).withOpacity(0.5),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "My Club",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            letterSpacing: 0.27,
                            color: Color(0xFF17262A),
                          ),
                        ),
                      ),
                      getMyClubUI(),
                      SizedBox(
                        height: 30,
                      ),
                      getSettingList()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                // border: Border.all(style: BorderStyle.solid),
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
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
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3293A45),
                  ),
                ),
                Text(
                  'U9205231W',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 0.27,
                    color: Color(0xFF22373D),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 60, right: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  border: Border.all(color: Color(0xFF3A5160))),
              width: 90,
              height: 35,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.white24,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  onTap: () {
                    //edit profile page
                  },
                  child: Center(
                    child: Text(
                      "Edit Profile",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 0.27,
                        color: Color(0xFF3A5160),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getMyClubUI() {
    return Container(
      // padding: const EdgeInsets.only(left: 28, right: 28),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.8,

      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: cLubList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      '${cLubList[index].logoUrl}',
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10)));
          }),
    );
  }

  Widget getSettingList() {
    return Expanded(
        child: ListView(
      padding: EdgeInsets.all(20),
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            leading: Icon(Icons.settings, color: EventAppTheme.grey),
            title: Text('Settings'),
            onTap: () {
              print("settings 1");
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            leading: Icon(
              Icons.favorite,
              color: EventAppTheme.grey,
            ),
            title: Text('My Favorites'),
            onTap: () {
              print("settings 2");
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            leading: Icon(Icons.phone, color: EventAppTheme.grey),
            title: Text('Contact Us'),
            onTap: () {
              print("settings 3");
            },
          ),
        )
      ],
    ));
  }

  Widget getAdminUI() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                RedeemConfirmationScreen()));
      },
      child: const Icon(Icons.manage_accounts),
      backgroundColor: Colors.green,
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
