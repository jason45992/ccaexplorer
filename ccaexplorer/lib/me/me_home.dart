import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:ccaexplorer/me/edit_profile.dart';
import 'package:ccaexplorer/me/favourates.dart';
import 'package:ccaexplorer/me/setting.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'admin_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/admin/published_events.dart';

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
          body: Stack(children: <Widget>[
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
                  padding: const EdgeInsets.only(left: 24.0, right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Color(0xFF364A54),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(36.0),
                              bottomLeft: Radius.circular(36.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(0xFF3A5160).withOpacity(0.4),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 25.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 6.0),
                                child: Text(
                                  "My Club  (${cLubList.length})",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    // h6 -> title
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 0.18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              getMyClubUI(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      getSettingList()
                    ],
                  ),
                ),
              ),
            ),
          ]),
          floatingActionButton: getAdminUI()),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0, left: 24, right: 24),
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
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    // h5 -> headline
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 0.27,
                    color: Color(0xFF17262A),
                  ),
                ),
                const SizedBox(height: 8),
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
            padding: const EdgeInsets.only(left: 30, right: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  border: Border.all(color: Colors.white, width: 1.5)),
              width: 100,
              height: 35,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.white24,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Edit Profile",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 0.27,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.mode_edit_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
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
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    elevation: 10,
                    shadowColor: Color(0xFF17262A).withOpacity(0.4),
                    margin: EdgeInsets.all(10)));
          }),
    );
  }

  Widget getSettingList() {
    return Expanded(
        child: ListView(
      padding: EdgeInsets.symmetric(vertical: 20),
      children: [
        Card(
          color: Colors.transparent,
          elevation: 0,
          shadowColor: EventAppTheme.grey.withOpacity(0),
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: Color(0xFFEDF0F2), width: 0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(Icons.settings, color: EventAppTheme.grey),
            title: Text('Settings',
                style: TextStyle(
                  // body1 -> body2
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  letterSpacing: 0.2,
                  color: Color(0xFF253840),
                )),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: EventAppTheme.grey.withOpacity(0.7),
              size: 24,
            ),
          ),
        ),
        // SizedBox(
        //   height: 5,
        // ),
        Card(
          elevation: 0,
          shadowColor: EventAppTheme.grey.withOpacity(0),
          shape: RoundedRectangleBorder(
            //  side: BorderSide(color: Color(0xFFEDF0F2), width: 0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(
              Icons.favorite,
              color: EventAppTheme.grey,
            ),
            title: Text('My Favorites',
                style: TextStyle(
                  // body1 -> body2
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  letterSpacing: 0.2,
                  color: Color(0xFF253840),
                )),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminPublishedEvents(),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: EventAppTheme.grey.withOpacity(0.7),
              size: 24,
            ),
          ),
        ),
        // SizedBox(
        //   height: 5,
        // ),
        Card(
          elevation: 0,
          shadowColor: EventAppTheme.grey.withOpacity(0),
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: Color(0xFFEDF0F2), width: 0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(Icons.phone, color: EventAppTheme.grey),
            title: Text('Contact Us',
                style: TextStyle(
                  // body1 -> body2
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  letterSpacing: 0.2,
                  color: Color(0xFF253840),
                )),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: EventAppTheme.grey.withOpacity(0.7),
              size: 24,
            ),
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
