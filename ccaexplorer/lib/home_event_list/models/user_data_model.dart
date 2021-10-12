import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../src/authentication_state.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../src/widgets.dart';
import '../../common_method/common_method_authentication.dart';

class ApplicationUserDetailState extends ChangeNotifier {
  ApplicationUserDetailState() {
    init();
  }

  Future<DocumentReference> addUser(String message) {
    if (AuthenticationCommon().loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('user').add(<String, dynamic>{
      'email': 'testUser@mail.com',
      'full_name': 'Test User',
      'matriculation_number': 'U19201234',
      'phone_number': 87654321,
      'profilepicture_id': 0,
    });
  }

  //init applicaiton State
  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        AuthenticationCommon().loginState = ApplicationLoginState.loggedIn;
        // User
        _userDetailSubscription = FirebaseFirestore.instance
            .collection('user')
            .snapshots()
            .listen((snapshot) {
          _userDetailList = [];
          snapshot.docs.forEach((document) {
            _userDetailList.add(
              UserDetails(
                fullName: document.data()['full_name'],
                email: document.data()['email'],
                matricNum: document.data()['matriculation_number'],
                phoneNum: document.data()['phone_number'],
                profilePicId: document.data()['profilepicture_id'],
              ),
            );
          });
          notifyListeners();
        });
      } else {
        AuthenticationCommon().loginState = ApplicationLoginState.loggedOut;
        // destory subscription
        _userDetailList = [];
        _userDetailSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  // User
  StreamSubscription<QuerySnapshot>? _userDetailSubscription;
  List<UserDetails> _userDetailList = [];
  List<UserDetails> get userDetailList => _userDetailList;
}

// user
class UserDetail extends StatefulWidget {
  // Modify the following line
  UserDetail({required this.addUser, required this.userDetails});
  final FutureOr<void> Function(String message) addUser;
  final List<UserDetails> userDetails; // new

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<UserDetail> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_UserState');
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
            await widget.addUser(_controller.text);
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
        for (var user in widget.userDetails)
          Paragraph('${user.fullName}: ${user.email}'),
        SizedBox(height: 8),
        // to here.
      ],
    );
  }
}

class UserDetails {
  UserDetails(
      {required this.fullName,
      required this.email,
      required this.matricNum,
      required this.phoneNum,
      required this.profilePicId});
  final String fullName;
  final String email;
  final String matricNum;
  final int phoneNum;
  final int profilePicId;
}
