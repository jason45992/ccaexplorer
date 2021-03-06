import 'package:ccaexplorer/club/club_detail/club_detail.dart';
import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:ccaexplorer/me/contact_us.dart';
import 'package:ccaexplorer/me/edit_profile.dart';
import 'package:ccaexplorer/me/favourates.dart';
import 'package:ccaexplorer/me/setting.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'admin_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ccaexplorer/club/club_detail/club_detail_data.dart' as Detail;

class MeHome extends StatefulWidget {
  MeHome();

  @override
  _MeHomeState createState() => _MeHomeState();
}

class _MeHomeState extends State<MeHome> {
  var storage = FirebaseStorage.instance;
  List<ClubDetails> cLubList = [];
  List<CLubLogoDetails> cLubLogoList = [];
  List<ClubMemberNumberList> cLubmemnoList = [];

  List<CLubMemberDetails> userClubList = [];
  List<CLubMemberDetails> cLubMemberList = [];
  User? user = FirebaseAuth.instance.currentUser;
  String username = '';
  bool isAdmin = false;
  String matricnum = '';
  String profileurl = '';

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
                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 160,
                        decoration: BoxDecoration(
                          color: EventAppTheme.spacer,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(36.0),
                              bottomLeft: Radius.circular(36.0),
                              bottomRight: Radius.circular(36.0),
                              topRight: Radius.circular(36.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(0xFF3A5160).withOpacity(0.0),
                                offset: const Offset(1.1, 2),
                                blurRadius: 0.0),
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
                                    color: EventAppTheme.darkText,
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
      padding: const EdgeInsets.only(top: 80.0, left: 25, right: 25),
      child: Row(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
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
              width: 70,
              height: 70,
              child: profileurl != ''
                  ? CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(profileurl),
                      backgroundColor: Colors.transparent)
                  : CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                      backgroundColor: Colors.transparent)),
          Container(
            width: 180,
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 0.27,
                    color: Color(0xFF17262A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  matricnum,
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
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  border: Border.all(color: Colors.white, width: 1.5)),
              width: 90,
              height: 35,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.white24,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalProfile(),
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
                    child: InkWell(
                      child: Image.network('${cLubList[index].logoUrl}',
                          fit: BoxFit.fill, errorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                        return CircularProgressIndicator();
                      }),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClubDetailPage(
                                Detail.Club.generateClubs(
                                    cLubList[index].id,
                                    cLubList[index].logoUrl,
                                    cLubList[index].name,
                                    cLubList[index].category,
                                    cLubList[index].description,
                                    cLubList[index].clubmemnum,
                                    cLubList[index].rating,
                                    cLubList[index].contact,
                                    true,
                                    cLubList[index].list)[0],
                                cLubMemberList),
                          ),
                        );
                      },
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    elevation: 5,
                    shadowColor: EventAppTheme.grey.withOpacity(0.3),
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
                builder: (context) => Favorites(),
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
                builder: (context) => ContactUs(),
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
    if (!isAdmin) {
      return Container();
    } else {
      return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  RedeemConfirmationScreen(cLubList)));
        },
        child: const Icon(Icons.manage_accounts),
        backgroundColor: Colors.green,
      );
    }
  }

  Future<void> getData() async {
    cLubList = [];
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
            rating: document.get('club_score').toString(),
            contact: document.get('contact').toString(),
            clubmemnum: '0',
            list: []),
      );
      FirebaseFirestore.instance
          .collection('album')
          .where('club_id', isEqualTo: document['id'])
          .snapshots()
          .listen((album) {
        album.docs.forEach((album1) {
          print(document['id']);
          FirebaseFirestore.instance
              .collection('file')
              .where('album_id', isEqualTo: album1['id'])
              .snapshots()
              .listen((file) {
            List<String> urlList = [];
            file.docs.forEach((file1) {
              urlList.add(file1['url']);
            });
            cLubList.forEach((element) {
              if (element.name == document['name']) {
                element.list = urlList;
                setState(() {});
              }
            });
          });
        });
      });
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
    // for club logo list

    // Get docs from collection reference
    for (int i = 0; i < cLubList.length; i++) {
      FirebaseFirestore.instance
          .collection('club_member')
          .where('club_id', isEqualTo: cLubList[i].id)
          .snapshots()
          .listen((user) {
        cLubmemnoList.add(
          ClubMemberNumberList(
              id: cLubList[i].id, clubmemberno: user.size.toString()),
        );
        cLubList.forEach((clubDetail) {
          cLubmemnoList.forEach((cLubmemnodetail) {
            if (cLubmemnodetail.id == clubDetail.id) {
              clubDetail.clubmemnum = cLubmemnodetail.clubmemberno;
            }
          });
        });
      });
    }
    FirebaseFirestore.instance
        .collection('useracc')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .forEach((element) {
      setState(() {
        profileurl = element['profile_pic_id'];
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
    userClubList = cLubMemberList
        .where((clubMemberDetail) => clubMemberDetail.userId == user!.uid)
        .toList();
    List<ClubDetails> tempCLubList = [];
    cLubList.forEach((x) {
      userClubList.forEach((y) {
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

    setState(() {
      username = userQuerySnapshot.docs.first.get('Name');
      matricnum = userQuerySnapshot.docs.first.get('Matric_no');
      isAdmin = userQuerySnapshot.docs.first.get('is_admin');
    });
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
      required this.logoUrl,
      required this.rating,
      required this.contact,
      required this.clubmemnum,
      required this.list});
  final String category;
  final String description;
  final String id;
  final String invitationCode;
  final String logoId;
  final String name;
  String logoUrl;
  final String rating;
  final String contact;
  String clubmemnum;
  List<String> list;

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

class ClubMemberNumberList {
  ClubMemberNumberList({required this.id, required this.clubmemberno});
  final String id;
  final String clubmemberno;
}

class CLubMemberDetails {
  CLubMemberDetails({required this.clubId, required this.userId});
  final String clubId;
  final String userId;
}
