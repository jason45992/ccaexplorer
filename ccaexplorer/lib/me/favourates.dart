import 'dart:ui';
import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:ccaexplorer/home_event_list/models/event_data_model.dart';
import 'package:ccaexplorer/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import '/admin/admin_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  AnimationController? animationController;
  List<HotelListData> publishedEventList = HotelListData.hotelList;
  User? user = FirebaseAuth.instance.currentUser;
  List<EventDetails> eventList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AdminTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    getEventList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AdminTheme.buildLightTheme().backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
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
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'My Favorites',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        if (eventList.isNotEmpty) {
                          showDeleteAllAlertDialog(context);
                        } else {
                          showEmptyAlertDialog(context);
                        }
                      }, // create new event
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.delete, color: Color(0xffb0b4b8)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getEventList() {
    return SizedBox(
      height: 680,
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.only(top: 0, left: 25, right: 25),
                height: 80,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: EventAppTheme.notWhite,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 170,
                        padding:
                            const EdgeInsets.only(left: 20, top: 7, bottom: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${eventList[index].eventTitle}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: EventAppTheme.darkText),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${eventList[index].datetime}',
                              style: TextStyle(
                                fontSize: 13,
                                color: EventAppTheme.grey,
                              ),
                            ),
                            Text(
                              '${eventList[index].place}',
                              style: TextStyle(
                                fontSize: 13,
                                color: EventAppTheme.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: EventAppTheme.nearlyBlack,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24.0)),
                        ),
                        height: 30,
                        width: 80,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white24,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100.0)),
                            onTap: () {
                              showDeleteItemAlertDialog(
                                  context, eventList[index].docId);
                            },
                            child: Center(
                              child: Text(
                                "Delete",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  letterSpacing: 0.27,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: eventList.length),
    );
  }

  Future<void> getData() async {
    eventList = [];
    FirebaseFirestore.instance
        .collection('my_favourite')
        .where('user_id', isEqualTo: user!.uid)
        .snapshots()
        .listen((data) {
      data.docs.forEach((favElement) {
        FirebaseFirestore.instance
            .collection('event')
            .where('eventid', isEqualTo: favElement.get('event_id'))
            .snapshots()
            .listen((data) {
          eventList.add(EventDetails(
            id: data.docs[0].data()['eventid'],
            club: data.docs[0].data()['club'],
            cover: data.docs[0].data()['cover'],
            datetime: data.docs[0].data()['datetime'],
            description: data.docs[0].data()['description'],
            eventTitle: data.docs[0].data()['event_title'],
            place: data.docs[0].data()['place'],
            poster: data.docs[0].data()['poster'],
            docId: favElement.id,
          ));
          setState(() {});
        });
      });
    });
  }

  removeItemFromFav(String docId) async {
    if (docId.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('my_favourite')
          .doc(docId)
          .delete()
          .then((value) => showSuccessAlertDialog(context))
          .catchError(
              (error) => print("Failed removing from favourite: $error"));
    }
  }

  removeAllFromFav() async {
    for (int i = 0; i < eventList.length; i++) {
      FirebaseFirestore.instance
          .collection('my_favourite')
          .doc(eventList[i].docId)
          .delete()
          .then((value) {
        getData();
        setState(() {});
      }).catchError((error) {
        print("Failed removing from favourite: $error");
      });
    }
    // getData();
  }

  showDeleteItemAlertDialog(BuildContext context, String docId) {
    // set up the button
    Widget yesButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        Navigator.of(context).pop();
        removeItemFromFav(docId);
      },
    );

    Widget noButton = TextButton(
      child: Text("NO"),
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
        "Remove current event from favourite list?",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [yesButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDeleteAllAlertDialog(BuildContext context) {
    // set up the button
    Widget yesButton = TextButton(
      child: Text("YES"),
      onPressed: () async {
        Navigator.of(context).pop();
        removeAllFromFav();
      },
    );

    Widget noButton = TextButton(
      child: Text("NO"),
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
        "Empty your favourite list?",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [yesButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showSuccessAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        getData();
        setState(() {});
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Successfully removed event.",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showEmptyAlertDialog(BuildContext context) {
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
        "No event detected, add your favourite events from home page.",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [okButton],
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
