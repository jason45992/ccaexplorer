import 'package:ccaexplorer/src/authentication_state.dart';
import 'package:ccaexplorer/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common_method/common_method_authentication.dart';
import 'dart:async';
import '../../home_event_list/models/user_data_model.dart';
import '../../home_event_list/models/event_data_model.dart';
import '../home_event_list/event_app_theme.dart';

// Widget _buildBody(BuildContext context) {
//  return StreamBuilder<QuerySnapshot>(
//    stream: FirebaseFirestore.instance.collection('event').snapshots(),
//    builder: (context, snapshot) {
//      if (!snapshot.hasData) return LinearProgressIndicator();

//      return _buildList(context, snapshot.data.documents);
//    },
//  );
// }

class TimetablePage extends StatefulWidget {
  @override
  createState() => new MyHomePageState();

// User
  StreamSubscription<QuerySnapshot>? _userDetailSubscription;
  List<UserDetails> _userDetailList = [];
  List<UserDetails> get userDetailList => _userDetailList;
}

class MyHomePageState extends State<TimetablePage> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Timetable'),
    Tab(text: 'Event'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: EventAppTheme.grey,
          title: TabBar(
            tabs: myTabs,
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 18),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
          ),
        ),
        // body: TabBarView(children: myTabs.map((Tab tab) => Center()).toList()),
        body: TabBarView(
          // children: myTabs.map((Tab tab) => Center()).toList()
          children: [
            SfCalendar(
              view: CalendarView.week,
              specialRegions: _getTimeRegions(),
            ),
            // SfCalendar(
            //   view: CalendarView.schedule,
            //   scheduleViewSettings: ScheduleViewSettings(
            //     appointmentItemHeight: 70,
            //   ),
            // ),
            _DismissibleApp(),
            // GetUserName(),
          ],
        ),
      ),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    var time1 = DateTime.parse("2021-10-06 08:00:00Z");
    var time2 = DateTime.parse("2021-10-07 12:00:00Z");
    var time3 = DateTime.parse("2021-10-08 14:00:00Z");

    regions.add(TimeRegion(
        startTime: time1,
        endTime: time1.add(Duration(hours: 2)),
        enablePointerInteraction: true,
        color: Colors.blue.withOpacity(0.2),
        text: 'Sport'));
    regions.add(TimeRegion(
        startTime: time2,
        endTime: time2.add(Duration(hours: 2)),
        enablePointerInteraction: true,
        color: Colors.green.withOpacity(0.2),
        text: 'Art'));
    regions.add(TimeRegion(
        startTime: time3,
        endTime: time3.add(Duration(hours: 1)),
        enablePointerInteraction: true,
        color: Colors.red.withOpacity(0.2),
        text: 'Event'));

    return regions;
  }
}

class _DismissibleApp extends StatefulWidget {
  @override
  _DismissibleAppState createState() => new _DismissibleAppState();
}

class _DismissibleAppState extends State<_DismissibleApp> {
  List<String> _values = ['Event1', 'Event2', 'Event3', 'Event4'];
  List<String> _times = [
    'Oganizaed by xxx Club \n10-10-2021',
    'Oganizaed by xxx Club \n11-10-2021',
    'Oganizaed by xxx Club \n12-10-2021',
    'Oganizaed by xxx Club \n13-10-2021'
  ];
  List<String> _remaining_times = [
    'In 3 days',
    'In 3 days',
    'In 1 week',
    'In 1 week'
  ];
  // final event = FirebaseFirestore.instance.collection('event');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Woolha.com Flutter Tutorial'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
            itemCount: _values.length,
            padding: const EdgeInsets.all(5.0),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key('item ${_values[index]}'),
                background: Container(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.favorite, color: Colors.white),
                        Text('Move to favorites',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.delete, color: Colors.white),
                        Text('Move to trash',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Confirmation"),
                        content: const Text(
                            "Are you sure you want to delete this item?"),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Delete")),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print("Add to favorite");
                  } else {
                    print('Remove item');
                  }

                  setState(() {
                    _values.removeAt(index);
                  });
                },
                child: ListTile(
                  title: Text(_values[index]),
                  subtitle: Text(_times[index]),
                  trailing: Text(_remaining_times[index]),
                ),
              );
            }),
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  // var doc_ref = FirebaseFirestore.instance.collection("event").doc();

  // final String documentId

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return FutureBuilder<DocumentSnapshot>(
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // if (snapshot.hasError) {
        //   return Text("Something went wrong");
        // }

        // if (snapshot.hasData && !snapshot.data!.exists) {
        //   return Text("Document does not exist");
        // }

        // if (snapshot.connectionState == ConnectionState.done) {
        //   // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        //   return Text("Full Name: ${_userDetailList[0]} ${_userDetailList[1]}");
        // }

        // return Text("Full Name: ${_userDetailList[0]} ${_userDetailList[1]}");
        return Consumer<ApplicationEventDetailState>(
          builder: (context, appState, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(appState.eventDetailList[0].poster)],
          ),
        );
      },
    );
  }
}

// List _clubDetailList = [];

// GetUserName(this.documentId);

// @override
// Widget build(BuildContext context) {

//   CollectionReference users = FirebaseFirestore.instance.collection('event');

//   return FutureBuilder<DocumentSnapshot>(
//     future: users.doc(documentId).get(),
//     builder:
//         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return Text("Something went wrong");
//       }

//       if (snapshot.hasData && !snapshot.data!.exists) {
//         return Text("Document does not exist");
//       }

//       if (snapshot.connectionState == ConnectionState.done) {
//         Map<String, dynamic> data =
//             snapshot.data!.data() as Map<String, dynamic>;
//         return Text("Full Name: ${data['club']} ");
//       }

//       return Text("loading");
//     },
//   );
// }

//   List<ClubDetails> _clubDetailList = [];
// }

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
  Meeting(this.userName, this.from, this.to, this.background, this.isAllDay);

  String userName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class UserDetails {
  UserDetails({required this.club});
  final String club;
}
