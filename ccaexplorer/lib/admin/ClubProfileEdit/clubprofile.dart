import 'package:ccaexplorer/admin_image_upload/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final controllerX = TextEditingController();
// ignore: non_constant_identifier_names
final event_description_controller = TextEditingController();
final phonecontroller = TextEditingController();

// ignore: camel_case_types
class clubprofile extends StatelessWidget {
  const clubprofile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Product page',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ClubProfile(),
    );
  }
}

class ClubProfile extends StatefulWidget {
  const ClubProfile({Key? key}) : super(key: key);

  @override
  _ClubProfileState createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile> {
  File? image;
  String logofileepath = '';
  List<File> logoImage = [];
  File? logoimage;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];

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
            logoImage.length != 0
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
            ElevatedButton(
              child: Text("Upload your Special Project"),
              onPressed: selectImages,
            ),
            gridview(),
            Description_Text(),
            contactnumber(),
            ButtonWidget(
              text: 'Update Profile',
              onClicked: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: MediaQuery.of(context).size.width,
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
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(width: 90),
          Text(
            'Club Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            padding: EdgeInsets.all(4),
            color: Colors.white,
            child: Text(
              'LOGO',
              style: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontWeight: FontWeight.w900),
            ),
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
                  width: 130,
                  height: 100,
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

  // ignore: non_constant_identifier_names
  Widget Description_Text() {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        maxLines: 4,
        controller: event_description_controller,
        decoration: InputDecoration(
          hintText: 'Write your club details...',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondRoute()),
          );
        },
      ),
    );
  }
}

Widget contactnumber() {
  return Container(
    margin: EdgeInsets.all(20),
    child: TextField(
      controller: phonecontroller,
      decoration: InputDecoration(
        hintText: 'Please input your event title',
        labelText: 'Your Contact Number',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
    ),
  );
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

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
                          Icons.arrow_back_ios,
                          color: Colors.black87,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      event_description_controller.text = controllerX.text;
                    },
                    icon: Icon(
                      Icons.done,
                      size: 30,
                      color: Colors.white,
                    ),
                    label: Text("Done",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
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
            )
          ],
        ),
      ),
    ));
  }
}

// class PhotoFrame extends StatefulWidget {
//   const PhotoFrame({Key? key}) : super(key: key);

//   @override
//   _PhotoFrameState createState() => _PhotoFrameState();
// }

// class _PhotoFrameState extends State<PhotoFrame> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(primary: Colors.transparent),
//         child: Icon(
//           Icons.add_a_photo,
//           color: Colors.black,
//         ),
//         onPressed: () {},
//       ),
//     );
//   }
// }
