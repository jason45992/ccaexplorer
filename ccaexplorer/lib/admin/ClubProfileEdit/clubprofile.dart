import 'dart:async';

import 'package:ccaexplorer/admin_image_upload/button_widget.dart';
import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:path/path.dart';
import 'package:readmore/readmore.dart';

final controllerX = TextEditingController();
// ignore: non_constant_identifier_names

final phonecontroller = TextEditingController();

class ClubProfile extends StatefulWidget {
  final String clubId;
  const ClubProfile(this.clubId, {Key? key}) : super(key: key);

  @override
  _ClubProfileState createState() => _ClubProfileState(this.clubId);
}

class _ClubProfileState extends State<ClubProfile> {
  final String clubId;
  _ClubProfileState(this.clubId);
  File? image;
  String logofileepath = '';
  List<File> logoImage = [];
  File? logoimage;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  List<DBImageFileDetails>? _dbimageFileList = [];
  String downloadUrl2 = '';
  String logoimageurl = '';
  String descriptionText = '';
  String contact = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _dbimageFileList = [];

    CollectionReference _clubRef =
        FirebaseFirestore.instance.collection('club');
    CollectionReference _fileRef =
        FirebaseFirestore.instance.collection('file');
    CollectionReference _albumRef =
        FirebaseFirestore.instance.collection('album');

    _clubRef.where('id', isEqualTo: widget.clubId).get().then((value) {
      value.docs.forEach((club) {
        _fileRef.where('id', isEqualTo: club['logo_id']).get().then((value) {
          value.docs.forEach((file) {
            setState(() {
              logoimageurl = file['url'];

              descriptionText = club['description'];
              controllerX.text = club['description'];
              phonecontroller.text = club['contact'].toString();
              contact = club['contact'].toString();
            });
          });
        });
      });
    });

    _albumRef.where('club_id', isEqualTo: widget.clubId).get().then((value) {
      value.docs.forEach((album) {
        _fileRef.where('album_id', isEqualTo: album['id']).get().then((value) {
          value.docs.forEach((file) {
            setState(() {
              _dbimageFileList!
                  .add(DBImageFileDetails(id: file['id'], url: file['url']));
            });
          });
        });
      });
    });
  }

  Future<void> deletedata(String id, String url) async {
    CollectionReference _fileRef =
        FirebaseFirestore.instance.collection('file');
    _fileRef.doc(id).delete();
    FirebaseStorage.instance.refFromURL(url).delete();
    init();
  }

  Future<void> uploadAlbumPhoto(String filePath) async {
    String downloadURL = '';
    await Firebase.initializeApp();
    File file = File(filePath);
    String fileName = basename(filePath);
    Reference ref = FirebaseStorage.instance.ref();
    await ref.child("albumimages/$fileName.jpeg").putFile(file);
    print("added to Firebase Storage");
    downloadURL = await FirebaseStorage.instance
        .ref('albumimages/$fileName.jpeg')
        .getDownloadURL();
    final fileRef = FirebaseFirestore.instance.collection('file').doc();
    final _albumRef = FirebaseFirestore.instance.collection('album').doc();
    int count = 0;

    FirebaseFirestore.instance
        .collection('album')
        .where('club_id', isEqualTo: widget.clubId)
        .get()
        .then((value) {
      value.docs.forEach((album) {
        fileRef.set(
            {'album_id': album['id'], 'id': fileRef.id, 'url': downloadURL});
        count++;
      });
      if (count == 0) {
        _albumRef
            .set({'club_id': widget.clubId, 'id': _albumRef.id}).then((value) {
          uploadAlbumPhoto(filePath);
        });
      }
    });

    setState(() {
      _imageFileList = [];
      init();
    });
  }

  Future<void> uploadFile(List<XFile> imageFileList) async {
    String downloadUrl = '';
    final fileCollection = FirebaseFirestore.instance.collection('file').doc();
    final albumCollection =
        FirebaseFirestore.instance.collection('album').doc();
    await Firebase.initializeApp();
    final albumCollectionId = albumCollection.id;
    fileCollection
        .set({
          'id': albumCollectionId,
          'club_id': downloadUrl,
        })
        .then((value) => print("Album Data Added"))
        .catchError((error) => print("Failed to add user: $error"));
    imageFileList.forEach((element) async {
      File file = File(element.path);
      String fileName = basename(element.path);
      Reference ref = FirebaseStorage.instance.ref();
      await ref.child("Album$albumCollectionId/$fileName.jpeg").putFile(file);
      print("added to Firebase Storage");
      downloadUrl = await FirebaseStorage.instance
          .ref('images/$fileName.jpeg')
          .getDownloadURL();
      // print(downloadUrl);

      fileCollection
          .set({
            'id': fileCollection.id,
            'url': downloadUrl,
            'album_id': albumCollectionId,
          })
          .then((value) => print("File Added"))
          .catchError((error) => print("Failed to add user: $error"));
    });
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      _imageFileList!.addAll(selectedImages);
      print('is not empty');
    }
    print('image list length  ' + _imageFileList!.length.toString());
    setState(() {});
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      logofileepath = image.path;
      logoImage.add(imageTemporary);
      setState(() {
        this.logoimage = logoImage[0];
      });
    } on PlatformException catch (e) {
      print('failed to pick image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            appBar(),
            logoimageurl != ''
                ? Stack(children: [
                    ClipOval(
                      child: Image.network(
                        logoimageurl,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        child: Icon(Icons.edit, size: 20, color: Colors.black),
                        onTap: () {
                          setState(() {
                            logoimageurl = '';
                          });
                        },
                      ),
                    ),
                  ])
                : logoImage.length != 0
                    ? Stack(children: [
                        ClipOval(
                          child: Image.file(
                            logoimage!,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                            child: Icon(
                              Icons.remove_circle,
                              size: 20,
                              color: Colors.red,
                            ),
                            onTap: () {
                              setState(() {
                                logoImage.removeAt(0);
                              });
                            },
                          ),
                        ),
                      ])
                    : imageX(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Your Existing Club Album",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            gridview(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 6,
                shadowColor: Colors.brown.withOpacity(0.5),
                primary: Colors.brown.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("Choose Your New Club Album Picture Here"),
              onPressed: selectImages,
            ),
            gridview2(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 6,
                shadowColor: Colors.brown.withOpacity(0.5),
                primary: Colors.brown.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("Add New Photos To Your Club Album"),
              onPressed: () {
                _imageFileList!.forEach((element) {
                  uploadAlbumPhoto(element.path);
                });
              },
            ),
            Description_Text(),
            contactnumber(),
            const SizedBox(
              height: 29,
            )
          ],
        ),
      ),
    );
  }

  deleteDBdialog(BuildContext context, String id, String url) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        deletedata(id, url);
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

  Widget appBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: MediaQuery.of(this.context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 32.0,
            width: 32.0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black87,
                ),
                onTap: () {
                  Navigator.pop(this.context);
                },
              ),
            ),
          ),
          const SizedBox(width: 75),
          Text(
            'Club Profile Edit',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget imageX() {
    return InkWell(
      child: Stack(children: [
        ClipOval(
          child: Image.network(
            'https://static.thenounproject.com/png/396915-200.png',
            width: 90,
            height: 90,
          ),
        ),
      ]),
      onTap: () {
        pickImage();
      },
    );
  }

  Widget gridview() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _dbimageFileList!.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            crossAxisSpacing: 2,
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Image.network(
                  _dbimageFileList![index].url,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.delete,
                      size: 25,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        deleteDBdialog(context, _dbimageFileList![index].id,
                            _dbimageFileList![index].url);
                      });
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget gridview2() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _imageFileList!.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            crossAxisSpacing: 2,
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Image.file(
                  File(_imageFileList![index].path),
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
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
                        _imageFileList!.removeAt(index);
                      });
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget Description_Text() {
    return Container(
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Club Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    this.context,
                    MaterialPageRoute(
                        builder: (context) => SecondRoute(
                              clubid: widget.clubId,
                            )),
                  );
                },
                icon: Icon(Icons.edit),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            width: double.maxFinite,
            child: ReadMoreText(
              descriptionText,
              trimLines: 3,
              colorClickableText: EventAppTheme.nearlyBlack,
              trimMode: TrimMode.Line,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                height: 1.5,
              ),
              trimCollapsedText: 'more',
              trimExpandedText: 'less',
            ),
          )
        ]));
  }

  Widget contactnumber() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Contact',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  this.context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ContactNumberEdit(clubid: widget.clubId)),
                );
              },
              icon: Icon(Icons.edit),
            )
          ],
        ),
        Container(
          width: double.maxFinite,
          child: Text(
            contact,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 15,
            ),
          ),
        )
      ]),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key, required this.clubid}) : super(key: key);
  final clubid;
  Future updateClubDescription() async {
    FirebaseFirestore.instance
        .collection('club')
        .where('id', isEqualTo: clubid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection('club').doc(element.id).set({
          'description': controllerX.text,
        }, SetOptions(merge: true));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 32.0,
                    width: 32.0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: TextField(
                  maxLines: 20,
                  controller: controllerX,
                  decoration: InputDecoration(
                    hintText: 'Write your event details',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.maxFinite,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: Colors.brown.withOpacity(0.5),
                    primary: Colors.brown.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Update Club Description Text"),
                  onPressed: () {
                    updateDescriptionTextdialog(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  updateDescriptionTextdialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        updateClubDescription();
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubProfile(clubid),
            ),
          );
        });
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
        "Confirm Update?",
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
}

class ContactNumberEdit extends StatelessWidget {
  const ContactNumberEdit({Key? key, required this.clubid}) : super(key: key);
  final clubid;
  Future updateContactNumber() async {
    FirebaseFirestore.instance
        .collection('club')
        .where('id', isEqualTo: clubid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection('club').doc(element.id).set({
          'contact': int.parse(phonecontroller.text),
        }, SetOptions(merge: true));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 32.0,
                    width: 32.0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: phonecontroller,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: EventAppTheme.darkText),
                  hintText: 'Please input your event title',
                  labelText: 'Edit your club contact number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.maxFinite,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: Colors.brown.withOpacity(0.5),
                    primary: Colors.brown.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Update Contact Number"),
                  onPressed: () {
                    updateContactNumberdialog(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  updateContactNumberdialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        updateContactNumber();
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubProfile(clubid),
            ),
          );
        });
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
        "Confirm Update?",
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
}

class DBImageFileDetails {
  DBImageFileDetails({
    required this.id,
    required this.url,
  });
  final String id;
  final String url;
}
