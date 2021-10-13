import 'package:ccaexplorer/admin/club_management.dart';
import 'package:ccaexplorer/admin/select_club.dart';
import 'package:ccaexplorer/home_event_list/event_home_screen.dart';
import 'package:ccaexplorer/home_event_list/models/event_data_model.dart';
import 'package:ccaexplorer/me/me_home.dart';
import 'package:ccaexplorer/pages/timetable_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ccaexplorer/app_theme.dart';
import 'package:ccaexplorer/register.dart';
import 'event_details/event_detail.dart';
import 'login/login.dart';
import 'package:ccaexplorer/pages/home_page.dart';
import 'src/authentication_state.dart';
import 'src/widgets.dart';
import 'authentication.dart';
import 'home_event_list/models/user_data_model.dart';
import 'me/admin_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common_method/common_method_authentication.dart';
import 'guest_book.dart';
import 'admin_image_upload/event_detail_admin.dart';
import 'admin/GridViewDemo.dart';
import 'admin/published_events.dart';
import 'admin/registration_list.dart';
import 'admin/participant_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationState()),
        ChangeNotifierProvider(create: (_) => ApplicationGuestBookState()),
        ChangeNotifierProvider(create: (_) => ApplicationUserDetailState()),
        ChangeNotifierProvider(create: (_) => ApplicationEventDetailState())
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Meetup',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.black,
            ),
        primarySwatch: Colors.blueGrey,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: GridViewDemo(title: 'Grid View Demo'),
      // home: AdminClubManagement(),
      // home: EventlHomeScreen(),
      home: HomeScreen(),
      // home: SignIn(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CCA Explorer'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/images/codelab.png'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, 'Title'),
          const IconAndDetail(Icons.location_city, 'Place'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Authentication(
              email: appState.email,
              loginState: appState.loginState,
              startLoginFlow: appState.startLoginFlow,
              verifyEmail: appState.verifyEmail,
              signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              cancelRegistration: appState.cancelRegistration,
              registerAccount: appState.registerAccount,
              signOut: appState.signOut,
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          const Paragraph(
            'Join us for a day full of Firebase Workshops and Pizza!',
          ),
          // Modify from here
          Consumer<ApplicationGuestBookState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (AuthenticationCommon().loginState ==
                    ApplicationLoginState.loggedIn) ...[
                  Header('Discussion'),
                  GuestBook(
                    addMessage: (String message) =>
                        appState.addMessageToGuestBook(message),
                    messages: appState.guestBookMessages,
                  ),
                ],
              ],
            ),
          ),
          Consumer<ApplicationUserDetailState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDetail(
                    addUser: (String message) => appState.addUser(message),
                    userDetails: appState.userDetailList)
              ],
            ),
          ),
          Consumer<ApplicationEventDetailState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(AuthenticationCommon().loginState.toString()),
                if (AuthenticationCommon().loginState ==
                    ApplicationLoginState.loggedIn) ...[
                  Header('Event'),
                  EventListDetail(
                      addevent: (String message) => appState.addEvent(message),
                      eventDetails: appState.eventDetailList)
                ],
              ],
            ),
          ),
          // To here.
        ],
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
