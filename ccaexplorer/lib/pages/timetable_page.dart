import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../main.dart';

class TimetablePage extends StatefulWidget {
  @override
  createState() => new MyHomePageState();
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
          backgroundColor: Colors.grey,
          title: TabBar(
            tabs: myTabs,
            isScrollable: true,
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

// class TimetablePage extends StatefulWidget {
//   TimetablePage({Key? key}) : super(key: key);

//   _TimetablePageState createState() => _TimetablePageState();
// }

// // class _TimetablePageState extends State<TimetablePage> {
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Timetable Page"),
// //       ),
// //     );
// //   }
// class _TimetablePageState extends State<TimetablePage> {
//   // Widget build(BuildContext context) {
//   //   return Container(

//   //     child: SfCalendar(
//   //       view: CalendarView.week,
//   //       specialRegions: _getTimeRegions(),
//   //     ),
//   //   );
//   // }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   // title: const Text("Timetable"),
//       //   // leading: IconButton(
//       //   //   icon: Icon(Icons.menu),
//       //   //   tooltip: 'Navigreation',
//       //   //   onPressed: () => debugPrint('Navigreation button is pressed'),
//       //   // ),
//       //   title: Text('...'),
//       // ),
//       // body: Center(
//       //   child: SfCalendar(
//       //     view: CalendarView.week,
//       //     specialRegions: _getTimeRegions(),
//       //   ),
//       // ),
//       body: Center(
//         child: ListView(
//           children: <Widget>[
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 FlatButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SfCalendar(
//                                   view: CalendarView.week,
//                                   specialRegions: _getTimeRegions(),
//                                 )),
//                       );
//                     },
//                     textColor: Colors.grey,
//                     child: Text('Timetable'),
//                     minWidth: 180),
//                 FlatButton(
//                     onPressed: () {
//                       print('Event');
//                       //forgot password screen
//                     },
//                     textColor: Colors.grey,
//                     child: Text('Event'),
//                     minWidth: 180),
//               ],
//             ),
//             Container(
//               height: 700,
//               color: Colors.amber[600],
//               child: Center(
//                   child: SfCalendar(
//                 view: CalendarView.week,
//                 specialRegions: _getTimeRegions(),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<TimeRegion> _getTimeRegions() {
//     final List<TimeRegion> regions = <TimeRegion>[];
//     regions.add(TimeRegion(
//         startTime: DateTime.now(),
//         endTime: DateTime.now().add(Duration(hours: 1)),
//         enablePointerInteraction: false,
//         color: Colors.grey.withOpacity(0.2),
//         text: 'Break'));

//     return regions;
//   }

//   List<Meeting> _getDataSource() {
//     final List<Meeting> meetings = <Meeting>[];
//     final DateTime today = DateTime.now();
//     final DateTime startTime =
//         DateTime(today.year, today.month, today.day, 9, 0, 0);
//     final DateTime endTime = startTime.add(const Duration(hours: 2));
//     meetings.add(Meeting(
//         'Conference', startTime, endTime, const Color(0xFF0F8644), false));
//     return meetings;
//   }
// }

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Reset Password"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
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
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
