import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudImageDemo extends StatefulWidget {
  CloudImageDemo({Key? key}) : super(key: key);

  @override
  _CloudImageDemoState createState() => _CloudImageDemoState();
}

class _CloudImageDemoState extends State<CloudImageDemo> {
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  File? _image;
  bool isLoading = false;
  bool isRetrieved = false;
  QuerySnapshot<Map<String, dynamic>>? cachedResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Cloud Images"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          !isRetrieved
              ? FutureBuilder(
                  future: getImages(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      isRetrieved = true;
                      cachedResult = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              contentPadding: EdgeInsets.all(8.0),
                              title: Text(
                                  snapshot.data!.docs[index].data()["name"]),
                              leading: Image.network(
                                  snapshot.data!.docs[index].data()["url"],
                                  fit: BoxFit.fill),
                            );
                          });
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Text("No data");
                    }
                    return CircularProgressIndicator();
                  },
                )
              : displayCachedList(),

          /// TODO: cache images correctly
          ElevatedButton(
              child: Text("Pick Image From Device"), onPressed: getImage),
          _image == null
              ? Text('No image selected.')
              : Image.file(
                  _image!,
                  height: 300,
                ),
          !isLoading
              ? ElevatedButton(
                  child: Text("Upload Image"),
                  onPressed: () async {
                    if (_image != null) {
                      setState(() {
                        this.isLoading = true;
                      });
                      Reference ref = FirebaseStorage.instance.ref();
                      TaskSnapshot addImg =
                          await ref.child("images/img").putFile(_image!);
                      if (addImg.state == TaskState.success) {
                        setState(() {
                          this.isLoading = false;
                        });
                        print("added to Firebase Storage");
                      }
                    }
                  })
              : CircularProgressIndicator(),
        ]),
      ),
    ));
  }

  Future getImage() async {
    final _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getImages() {
    return fb.collection("images").get();
  }

  ListView displayCachedList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cachedResult!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          print(cachedResult!.docs[index].data()["url"]);
          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(cachedResult!.docs[index].data()["name"]),
            leading: Image.network(cachedResult!.docs[index].data()["url"],
                fit: BoxFit.fill),
          );
        });
  }
}
