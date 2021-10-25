import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimeTable extends StatefulWidget {
  TimeTable();

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  var storage = FirebaseStorage.instance;
  late List<AssetImage> listOfImage;
  bool clicked = false;
  List<String?> listOfStr = [];
  String? images;
  bool isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;

  List<Meeting> events = <Meeting>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  final List<Tab> myTabs = <Tab>[Tab(text: 'Timetable'), Tab(text: 'Event')];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: EventAppTheme.light_grey,
          title: TabBar(
            tabs: myTabs,
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 18),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            SfCalendar(
              view: CalendarView.week,
              dataSource: MeetingDataSource(events),
              showDatePickerButton: true,
              onTap: timeTableTapped,
            ),
            // _DismissibleApp(),
            SfCalendar(
              dataSource: MeetingDataSource(events),
              view: CalendarView.schedule,
              onTap: eventTapped,
              scheduleViewSettings: ScheduleViewSettings(
                weekHeaderSettings: WeekHeaderSettings(
                    startDateFormat: 'dd MMM ',
                    endDateFormat: 'dd MMM, yy',
                    height: 50,
                    textAlign: TextAlign.center,
                    backgroundColor: Colors.grey,
                    weekTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),
                hideEmptyScheduleWeek: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('event');

  Future<void> getData() async {
    events = [];

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    List<EventDetails> _eventDetailList = [];
    _eventDetailList = [];
    querySnapshot.docs.forEach((document) {
      _eventDetailList.add(
        EventDetails(
          eventId: document.get('eventid'),
          club: document.get('club'),
          cover: document.get('cover'),
          datetime: document.get('datetime'),
          description: document.get('description'),
          eventTitle: document.get('event_title'),
          place: document.get('place'),
          poster: document.get('poster'),
        ),
      );
    });

    List<int> colorCode = [
      0xFF4a4e4d,
      0xFFfe4a49,
      0xFF03da4ab,
      0xFF0f6cd61,
      0xFF0fe8a71,
      0xFF4a4e4d,
      0xFFfe4a49,
      0xFF03da4ab,
      0xFF0f6cd61,
      0xFF0fe8a71,
      0xFF4a4e4d,
      0xFFfe4a49,
      0xFF03da4ab,
      0xFF0f6cd61,
      0xFF0fe8a71
    ];

    _eventDetailList.asMap().forEach((index, element) {
      final String eventTitle = element.eventTitle;
      final String eventId = element.eventId;
      final String place = element.place;
      final DateTime startTime =
          new DateFormat("yyyy-MM-dd hh:mm:ss").parse(element.datetime);
      final DateTime endTime = startTime.add(const Duration(hours: 2));
      events.add(Meeting(eventId, eventTitle, place, startTime, endTime,
          Color(colorCode[index]), false));
    });
  }

  String? _subjectText = '',
      _eventId = '',
      _locationText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '';

  void timeTableTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Meeting appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.eventName;
      _locationText = appointmentDetails.place;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.from)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.from).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.to).toString();
      _timeDetails = '$_startTimeText - $_endTimeText';
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subjectText')),
              content: Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Location: $_locationText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Text(
                          'Date: $_dateText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 20,
                      child: Row(
                        children: <Widget>[
                          Text('Time: $_timeDetails',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('Back'))
              ],
            );
          });
    }
  }

  void eventTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Meeting appointmentDetails = details.appointments![0];
      _eventId = appointmentDetails.eventId;
      _subjectText = appointmentDetails.eventName;
      _locationText = appointmentDetails.place;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.from)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.from).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.to).toString();
      _timeDetails = '$_startTimeText - $_endTimeText';
      print(appointmentDetails);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subjectText')),
              content: Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Location: $_locationText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Text(
                          'Date: $_dateText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 20,
                      child: Row(
                        children: <Widget>[
                          Text('Time: $_timeDetails',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showConfirm(_eventId!);
                    },
                    child: new Text(
                      'Delete',
                      style: TextStyle(color: EventAppTheme.darkText),
                    )),
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        new Text('Back', style: TextStyle(color: Colors.grey)))
              ],
            );
          });
    }
  }

  void showConfirm(String eventId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: new Text('Cancel Event')),
            content: Container(
              height: 100,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: Text(
                          'Are you sure you want to cancel this event?',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showCancelSuccess(eventId);
                  },
                  child: new Text('Yes')),
              new TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('No'))
            ],
          );
        });
  }

  void showCancelSuccess(String eventId) {
    events = events.where((element) => element.eventId != eventId).toList();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: new Text('Cancel Event')),
            content: Container(
              height: 100,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: Text(
                          'Event cancelled successfully!',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: new Text('Ok'))
            ],
          );
        });
  }
}

//for time table view
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  String getPlace(int index) {
    return appointments![index].place;
  }

  String getEventId(int index) {
    return appointments![index].eventId;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventId, this.eventName, this.place, this.from, this.to,
      this.background, this.isAllDay);
  String eventId;
  String eventName;
  String place;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class EventDetails {
  EventDetails(
      {required this.eventId,
      required this.club,
      required this.cover,
      required this.datetime,
      required this.description,
      required this.eventTitle,
      required this.place,
      required this.poster});
  final String eventId;
  final String club;
  final String cover;
  final String datetime;
  final String description;
  final String eventTitle;
  final String place;
  final String poster;

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'club': club,
      'cover': cover,
      'datetime': datetime,
      'description': description,
      'eventTitle': eventTitle,
      'covplaceer': place,
      'poster': poster,
    };
  }
}
