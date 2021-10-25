// import 'package:ccaexplorer/event_details/event_register.dart';
import 'package:ccaexplorer/home_event_list/event_app_theme.dart';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:full_screen_image/full_screen_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetail extends StatefulWidget {
  const EventDetail(
      {Key? key,
      required this.id,
      required this.eventname,
      required this.datetime,
      required this.venue,
      required this.club,
      required this.description,
      required this.eventposter})
      : super(key: key);
  final String id;
  final String eventname;
  final String datetime;
  final String venue;
  final String club;
  final String description;
  final String eventposter;

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  var storage = FirebaseStorage.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var buttonText = "Register";
  var isClickable = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              imagepad(),
              desciption_title(),
              desciption_body(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 30),
        child: SizedBox(
          width: double.maxFinite,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              if (isClickable) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => EventRegisterPage()),
                // );
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: EventAppTheme.grey.withOpacity(0.4),
              primary: EventAppTheme.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    FirebaseFirestore.instance
        .collection('event_application')
        .where('user_id', isEqualTo: user!.uid)
        .snapshots()
        .listen((data) {
      data.docs.forEach((element) {
        if (element.get("event_id") == widget.id) {
          buttonText = "Registered";
          isClickable = false;
          setState(() {});
        }
      });
    });
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.transparent,
              offset: const Offset(0, 0),
              blurRadius: 0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: EventAppTheme.darkerText,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Respond to button press
              },
              icon: Icon(
                Icons.star,
                size: 20,
                color: Colors.yellow,
              ),
              label: Text("Favourite",
                  style: TextStyle(color: EventAppTheme.darkerText)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imagepad() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(children: <Widget>[
          image(),
          const SizedBox(width: 15),
          Container(
            height: 200.0,
            width: 190,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: ClipRRect(
              child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 8),
                  child: text()),
            ),
          )
        ]),
      );

  Widget image() => Container(
        height: 180.0,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: FullScreenWidget(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.eventposter,
            ),
          ),
        ),
      );

  Widget text() => Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.eventname,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.club,
              style: TextStyle(
                color: Colors.grey.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  color: EventAppTheme.grey,
                  size: 25,
                ),
                VerticalDivider(),
                Expanded(
                  child: Text(widget.datetime, style: TextStyle(fontSize: 15)),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: EventAppTheme.grey,
                  size: 25,
                ),
                VerticalDivider(),
                Text(widget.venue, style: TextStyle(fontSize: 15))
              ],
            ),
          ],
        ),
      );

  static const TextStyle titlestyle = TextStyle(
      color: Colors.black87, fontSize: 13.0, fontWeight: FontWeight.bold);

  Widget desciption_title() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.all(5),
          child: Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );

  Widget desciption_body() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(5),
          child: Text(
            widget.description,
            style: TextStyle(
                fontSize: 16, fontStyle: FontStyle.normal, height: 1.6),
          ),
        ),
      );
  showAlertDialog(BuildContext context) {
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
        "Application submitted successfully.",
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
}
