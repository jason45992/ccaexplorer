import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../src/authentication_state.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../src/widgets.dart';
import '../../common_method/common_method_authentication.dart';

class ApplicationEventDetailState extends ChangeNotifier {
  ApplicationEventDetailState() {
    init();
  }

  Future<DocumentReference> addEvent(String message) {
    if (AuthenticationCommon().loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('event').add(<String, dynamic>{
      'club': 'Student Union',
      'cover': 'Description',
      'datetime': 'Friday, October 8, 2021 4:39 PM',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fug',
      'event_title': 'Competition',
      'place': 'NTU LT19',
      'poster':
          "https://firebasestorage.googleapis.com/v0/b/cca-explorer.appspot.com/o/images%2FFile%3A%20'%2Fdata%2Fevent%2F0%2Fcom.dip054.ccaexplorer%2Fcache%2Fimage_picker2916490940084265046.png'.jpeg?alt=media&token=1c4b0c1d-9b28-4017-a69a-745ee16d3575",
    });
  }

  //init applicaiton State
  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null) {
        AuthenticationCommon().loginState = ApplicationLoginState.loggedIn;
        // event
        _eventDetailSubscription = FirebaseFirestore.instance
            .collection('event')
            .snapshots()
            .listen((snapshot) {
          _eventDetailList = [];
          snapshot.docs.forEach((document) {
            _eventDetailList.add(
              EventDetails(
                club: document.data()['club'],
                cover: document.data()['cover'],
                datetime: document.data()['datetime'],
                description: document.data()['description'],
                eventTitle: document.data()['event_title'],
                place: document.data()['place'],
                poster: document.data()['poster'],
              ),
            );
          });
          notifyListeners();
        });
      } else {
        AuthenticationCommon().loginState = ApplicationLoginState.loggedOut;
        // destory subscription
        _eventDetailList = [];
        _eventDetailSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  // event
  StreamSubscription<QuerySnapshot>? _eventDetailSubscription;
  List<EventDetails> _eventDetailList = [];
  List<EventDetails> get eventDetailList => _eventDetailList;
  set setEventDetailList(List<EventDetails> list) => _eventDetailList = list;
}

// event
class EventListDetail extends StatefulWidget {
  // Modify the following line
  EventListDetail({required this.addevent, required this.eventDetails});
  final FutureOr<void> Function(String message) addevent;
  final List<EventDetails> eventDetails; // new

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<EventListDetail> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_eventState');
  final _controller = TextEditingController();

  @override
  // Modify from here
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 8),
        StyledButton(
          onPressed: () async {
            await widget.addevent(_controller.text);
            _controller.clear();
          },
          child: Row(
            children: [
              Icon(Icons.send),
              SizedBox(width: 4),
              Text('SEND'),
            ],
          ),
        ),
        SizedBox(height: 8),
        for (var event in widget.eventDetails)
          Paragraph('${event.club}: ${event.eventTitle}'),
        SizedBox(height: 8),
        // to here.
      ],
    );
  }
}

class EventDetails {
  EventDetails(
      {required this.club,
      required this.cover,
      required this.datetime,
      required this.description,
      required this.eventTitle,
      required this.place,
      required this.poster});
  final String club;
  final String cover;
  final String datetime;
  final String description;
  final String eventTitle;
  final String place;
  final String poster;
}
