import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:ccaexplorer/me/edit_profile.dart';
import 'package:ccaexplorer/me/favourates.dart';
import 'package:ccaexplorer/me/setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication.dart';
import '../home_event_list/models/user_data_model.dart';
import 'admin_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ccaexplorer/home_event_list/models/user_data_model.dart';
import '../home_event_list/models/user_data_model.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ApplicationState()),
//         ChangeNotifierProvider(create: (_) => ApplicationUserDetailState()),
//       ],
//       child: MeHome(),
//     ),
//   );
// }

class MeHome extends StatefulWidget {
  MeHome();

  @override
  _MeHomeState createState() => _MeHomeState();
}

class _MeHomeState extends State<MeHome> {
  var storage = FirebaseStorage.instance;
  late List<AssetImage> listOfImage;
  bool clicked = false;
  List<String?> listOfStr = [];
  String? images;
  bool isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              getAppBarUI(),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 25, right: 18),
                alignment: Alignment.topLeft,
                child: Text(
                  "My Club",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: 0.27,
                    color: Color(0xFF17262A),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              getMyClubUI(),
              SizedBox(
                height: 10,
              ),
              getSettingList(),
              // _offsetPopup()
            ],
          ),
          floatingActionButton: getAdminUI()),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            child: Image.asset('assets/images/userImage.png'),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getuserid(),
                Text(
                  'Matric Num',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    letterSpacing: 0.27,
                    color: Color(0xFF17262A),
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
                  border: Border.all(color: Color(0xFF00B6F0))),
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
                      builder: (context) => EditProfile(),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Edit Profile",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 0.27,
                        color: Color(0xFF00B6F0),
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
        width: MediaQuery.of(context).size.width * 0.9,
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xFF3A5160),
          borderRadius: const BorderRadius.all(Radius.circular(28.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xFF3A5160).withOpacity(0.7),
                offset: const Offset(0.8, 0.8),
                blurRadius: 5.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  print("Container 1 clicked");
                },
                child: Column(children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/images/userImage.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Club Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.27,
                      color: Color(0xFFFFFFFF),
                    ),
                  )
                ]),
              ),
              InkWell(
                onTap: () {
                  print("Container 2 clicked");
                },
                child: Column(children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/images/userImage.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Club Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.27,
                      color: Color(0xFFFFFFFF),
                    ),
                  )
                ]),
              ),
              InkWell(
                onTap: () {
                  print("Container 3 clicked");
                },
                child: Column(children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/images/userImage.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Club Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.27,
                      color: Color(0xFFFFFFFF),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ));
  }

  Widget getSettingList() {
    return Expanded(
        child: ListView(
      padding: EdgeInsets.all(20),
      children: [
        Card(
          elevation: 2,
          shadowColor: EventAppTheme.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(Icons.settings, color: EventAppTheme.grey),
            title: Text('Settings'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 2,
          shadowColor: EventAppTheme.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(
              Icons.favorite,
              color: EventAppTheme.grey,
            ),
            title: Text('My Favorites'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminPublishedEvents(),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 2,
          shadowColor: EventAppTheme.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(Icons.phone, color: EventAppTheme.grey),
            title: Text('Contact Us'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ),
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

  Widget getuserid() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('useracc');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(user!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            data['Name'],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 0.2,
              color: Color(0xFF3A5160),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
