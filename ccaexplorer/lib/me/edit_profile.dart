import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:ccaexplorer/me/contact_us.dart';
import 'package:ccaexplorer/me/edit_profile.dart';
import 'package:ccaexplorer/me/favourates.dart';
import 'package:ccaexplorer/me/setting.dart';
import 'package:ccaexplorer/me/contact_us.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'admin_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/admin/published_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '/admin_image_upload/models/admin_image_event_model.dart';

class PersonalProfile extends StatefulWidget {
  PersonalProfile();

  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  // ignore: non_constant_identifier_names
  final event_titile_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final event_venue_controller = TextEditingController();

  final timeinput = TextEditingController();
  var storage = FirebaseStorage.instance;
  List<ClubDetails> cLubList = [];
  List<CLubLogoDetails> cLubLogoList = [];
  List<CLubMemberDetails> cLubMemberList = [];
  User? user = FirebaseAuth.instance.currentUser;
  String username = '';
  String matricnum = '';
  String email = '';
  File? image;

  String? dropdownValue;
  // ignore: non_constant_identifier_names
  String file_path1 = '';
  String downloadUrl = '';
  // ignore: non_constant_identifier_names

  List<File> images1 = [];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      file_path1 = image.path;
      images1.add(imageTemporary);

      print(image.path);
      setState(() {
        this.image = images1[0];
      });
    } on PlatformException catch (e) {
      print('failed to pick image:$e');
    }
  }

  Future<void> uploadFile(String filePath) async {
    await Firebase.initializeApp();
    File file = File(filePath);
    String fileName = basename(filePath);

    Reference ref = FirebaseStorage.instance.ref();
    await ref.child("profileimages/$fileName.jpeg").putFile(file);
    print("added to Firebase Storage");
    downloadUrl = await FirebaseStorage.instance
        .ref('profileimages/$fileName.jpeg')
        .getDownloadURL();
    addEvent();
  }

  Future<void> addEvent() async {
    await Firebase.initializeApp();
    final userAcc = FirebaseFirestore.instance.collection('useracc');

    return userAcc
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'profile_pic_id': downloadUrl});
  }

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
              child: Column(
                children: [
                  const SizedBox(height: 9),
                  images1.length != 0
                      ? Stack(children: [
                          ClipOval(
                            child: Image.file(
                              image!,
                              width: 100,
                              height: 100,
                              //fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              child: Icon(
                                Icons.remove_circle,
                                size: 25,
                                color: Colors.red,
                              ),
                              onTap: () {
                                setState(() {
                                  images1.removeAt(0);
                                });
                              },
                            ),
                          ),
                        ])
                      : buildButton(
                          icon: Icons.upload_outlined,
                          onClicked: () => pickImage(),
                        ),
                ],
              ),
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
                            text: "Matric No: ",
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
              ],
            ),
            const SizedBox(height: 350),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.maxFinite,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    if (file_path1 != '') {
                      uploadFile(file_path1);
                      showAlertDialog(context);
                    } else {
                      showAlertDialog2(context);
                    }
                  },
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Profile  updated.",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [
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

  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
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
        "Image is required!!!",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [
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

  Widget buildButton({
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      Container(
        width: 130,
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            onPrimary: Colors.black,
          ),
          onPressed: onClicked,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28),
              const SizedBox(),
            ],
          ),
        ),
      );

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
