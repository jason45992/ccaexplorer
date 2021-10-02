import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../src/authentication.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../src/widgets.dart';

class ApplicationUserDetailState extends ChangeNotifier {
  ApplicationUserDetailState() {
    init();
  }
  // add method for guest book
  // Future<DocumentReference> addMessageToGuestBook(String message) {
  //   if (_loginState != ApplicationLoginState.loggedIn) {
  //     throw Exception('Must be logged in');
  //   }

  //   return FirebaseFirestore.instance
  //       .collection('guestbook')
  //       .add(<String, dynamic>{
  //     'text': message,
  //     'timestamp': DateTime.now().millisecondsSinceEpoch,
  //     'name': FirebaseAuth.instance.currentUser!.displayName,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //   });
  // }

  //init applicaiton State
  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
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
        _loginState = ApplicationLoginState.loggedOut;
        // destory subscription
        _userDetailList = [];
        _userDetailSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
  String? _email;
  String? get email => _email;

  // User
  StreamSubscription<QuerySnapshot>? _userDetailSubscription;
  List<UserDetails> _userDetailList = [];
  List<UserDetails> get userDetailList => _userDetailList;

  // Authenticaiton
  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(String email, String displayName, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateProfile(displayName: displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}

// user
class UserDetail extends StatefulWidget {
  // Modify the following line
  UserDetail({required this.userDetails});
  // final FutureOr<void> Function(String message) addUser;
  final List<UserDetails> userDetails; // new

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<UserDetail> {
  // final _formKey = GlobalKey<FormState>(debugLabel: '_UserState');
  // final _controller = TextEditingController();

  @override
  // Modify from here
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
