import 'package:ccaexplorer/admin_image_upload/models/admin_image_event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
final event_description_controller = TextEditingController();
final controllerX = TextEditingController();

// ignore: camel_case_types

class AdminEditEventForm extends StatefulWidget {
  final String clubName;
  final String eventTitle;
  final String eventTime;
  final String eventVenue;
  final String eventDetails;
  final String eventId;
  final String cover;
  final String poster;

  AdminEditEventForm(this.clubName, this.eventTitle, this.eventTime,
      this.eventVenue, this.eventDetails, this.eventId, this.cover, this.poster,
      {Key? key})
      : super(key: key);
  @override
  _AdminEditEventFormState createState() => _AdminEditEventFormState(clubName,
      eventTitle, eventTime, eventVenue, eventDetails, eventId, cover, poster);
}

class _AdminEditEventFormState extends State<AdminEditEventForm> {
  // ignore: non_constant_identifier_names
  final event_titile_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final event_venue_controller = TextEditingController();
  final String clubName;
  final String eventTitle;
  final String eventTime;
  final String eventVenue;
  final String eventDetails;
  final String eventId;
  final String cover;
  final String poster;
  final timeinput = TextEditingController();
  _AdminEditEventFormState(
      this.clubName,
      this.eventTitle,
      this.eventTime,
      this.eventVenue,
      this.eventDetails,
      this.eventId,
      this.cover,
      this.poster);
  File? image;
  File? image2;
  String? dropdownValue;
  // ignore: non_constant_identifier_names
  String file_path1 = '';
  String coverurl = '';
  String posterurl = '';
  String eventDescription = '';
  // ignore: non_constant_identifier_names
  String file_path2 = '';
  List<File> images1 = [];
  List<File> images2 = [];
  void init() {
    event_titile_controller.text = widget.eventTitle;
    event_venue_controller.text = widget.eventVenue;
    timeinput.text = widget.eventTime;
    event_description_controller.text = widget.eventDetails;
    coverurl = cover;
    posterurl = poster;
    controllerX.text = widget.eventDetails;
  }

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

  Future pickCImage() async {
    try {
      final image2 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image2 == null) return;
      final imageTemporary = File(image2.path);
      file_path2 = image2.path;
      images2.add(imageTemporary);
      setState(() {
        this.image2 = images2[0];
      });
    } on PlatformException catch (e) {
      print('failed to pick image:$e');
    }
  }

  @override
  void initState() {
    timeinput.text = "";
    super.initState();
    init();

    event_titile_controller.addListener(() => setState(() {}));
    event_venue_controller.addListener(() => setState(() {}));
    event_description_controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Scaffold(
          body: ListView(
            padding: EdgeInsets.all(32),
            children: [
              appBar(),
              const SizedBox(height: 20),
              EventTitle(),
              const SizedBox(height: 24),
              Organiser(),
              const SizedBox(height: 24),
              time_input(),
              const SizedBox(height: 24),
              Place(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Add Cover',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 9),
                        coverurl != ''
                            ? Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    coverurl,
                                    width: 130,
                                    height: 100,
                                    fit: BoxFit.cover,
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
                                        coverurl = '';
                                      });
                                    },
                                  ),
                                ),
                              ])
                            : images1.length != 0
                                ? Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        image!,
                                        width: 130,
                                        height: 100,
                                        fit: BoxFit.cover,
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
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Add Poster',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 9),
                        posterurl != ''
                            ? Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    posterurl,
                                    width: 130,
                                    height: 100,
                                    fit: BoxFit.cover,
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
                                        posterurl = '';
                                      });
                                    },
                                  ),
                                ),
                              ])
                            : images2.length != 0
                                ? Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        image2!,
                                        width: 130,
                                        height: 100,
                                        fit: BoxFit.cover,
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
                                            images2.removeAt(0);
                                          });
                                        },
                                      ),
                                    ),
                                  ])
                                : buildButton(
                                    icon: Icons.upload_outlined,
                                    onClicked: () => pickCImage(),
                                  ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Description_Text(),
              const SizedBox(height: 24),
              // Description_Text(),
              const SizedBox(height: 24),
              UpdateEvent(
                  event_titile_controller.text,
                  event_venue_controller.text,
                  timeinput.text,
                  dropdownValue,
                  file_path1,
                  file_path2,
                  event_description_controller.text,
                  eventId,
                  clubName),
            ],
          ),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget EventTitle() {
    return TextField(
      controller: event_titile_controller,
      decoration: InputDecoration(
        hintText: 'Please input your event title',
        labelText: 'Event Title',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  // ignore: non_constant_identifier_names
  Widget time_input() {
    return TextField(
        controller: timeinput,
        decoration: InputDecoration(
          hintText: 'Enter Time',
          labelText: 'Event Time',
          border: OutlineInputBorder(),
        ),
        onTap: () async {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime(2020, 5, 5, 20, 50),
              maxTime: DateTime(2030, 6, 7, 05, 09), onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            String time = DateFormat("yyyy-MM-dd hh:mm:ss").format(date);

            setState(() {
              timeinput.text = time; //set the value of text field.
            });
          }, locale: LocaleType.en);
        });
  }

  // ignore: non_constant_identifier_names
  Widget Place() {
    return TextField(
      controller: event_venue_controller,
      decoration: InputDecoration(
        hintText: 'Please input Event Venue',
        labelText: 'Event Venue',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget appBar() {
    return Container(
      alignment: Alignment.centerLeft,
      width: AppBar().preferredSize.height + 40,
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              height: 32.0,
              width: 32.0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                ),
              )),
          Expanded(
            child: Center(
              child: Text(
                'Update Event',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
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

  // ignore: non_constant_identifier_names
  Widget Organiser() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text('Select an organiser'),
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 20,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 15),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>[widget.clubName]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Description_Text() {
    return Container(
      child: TextField(
        maxLines: 10,
        controller: event_description_controller,
        decoration: InputDecoration(
          labelText: 'Write your event details',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondRoute(),
            ),
          );
        },
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  SecondRoute({
    Key? key,
  }) : super(key: key);

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
                        onTap: () {
                          Navigator.of(context).pop();
                        },
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
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
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
