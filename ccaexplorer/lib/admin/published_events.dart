import 'dart:ui';
import 'package:ccaexplorer/admin/editeventdetails.dart';
import 'package:ccaexplorer/admin_image_upload/event_detail_admin.dart';
import 'package:ccaexplorer/admin/registration_list.dart';
import 'package:ccaexplorer/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'admin_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPublishedEvents extends StatefulWidget {
  final String clubName;
  AdminPublishedEvents(this.clubName, {Key? key}) : super(key: key);

  @override
  _AdminPublishedEventsState createState() =>
      _AdminPublishedEventsState(clubName);
}

class _AdminPublishedEventsState extends State<AdminPublishedEvents> {
  AnimationController? animationController;
  List<HotelListData> publishedEventList = HotelListData.hotelList;
  final String clubName;
  List<EventDetails> _eventDetailList = [];

  _AdminPublishedEventsState(this.clubName);

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
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
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
                  'Published Events',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AdminEventForm(widget.clubName),
                          ),
                        );
                      }, // create new event
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.plusCircle,
                            color: Color(0xffb0b4b8)),
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
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                height: 80,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 170,
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${_eventDetailList[index].eventTitle}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            Text(
                              '${_eventDetailList[index].datetime}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${_eventDetailList[index].place}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffb0b4b8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24.0)),
                            border: Border.all(color: Color(0xffb0b4b8))),
                        height: 30,
                        width: 60,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white24,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100.0)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminRegistrationList(
                                      _eventDetailList[index]),
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                "List",
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
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffb0b4b8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24.0)),
                            border: Border.all(color: Color(0xffb0b4b8))),
                        height: 30,
                        width: 60,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white24,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100.0)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminEditEventForm(
                                      _eventDetailList[index].club,
                                      _eventDetailList[index].eventTitle,
                                      _eventDetailList[index].datetime,
                                      _eventDetailList[index].place,
                                      _eventDetailList[index].description,
                                      _eventDetailList[index].id,
                                      _eventDetailList[index].cover,
                                      _eventDetailList[index].poster),
                                ),
                              );
                              //edit profile page
                            },
                            child: Center(
                              child: Text(
                                "Edit",
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
          itemCount: _eventDetailList.length),
    );
  }

  Future<void> getData() async {
    FirebaseFirestore.instance
        .collection('event')
        .where('club', isEqualTo: clubName)
        .snapshots()
        .listen((data) {
      data.docs.forEach((document) {
        _eventDetailList.add(EventDetails(
          id: document.data()['eventid'],
          club: document.data()['club'],
          cover: document.data()['cover'],
          datetime: document.data()['datetime'],
          description: document.data()['description'],
          eventTitle: document.data()['event_title'],
          place: document.data()['place'],
          poster: document.data()['poster'],
        ));
      });
      setState(() {});
    });
  }
}

class EventDetails {
  EventDetails({
    required this.id,
    required this.club,
    required this.cover,
    required this.datetime,
    required this.description,
    required this.eventTitle,
    required this.place,
    required this.poster,
  });
  final String id;
  final String club;
  final String cover;
  final String datetime;
  final String description;
  final String eventTitle;
  final String place;
  final String poster;
}
