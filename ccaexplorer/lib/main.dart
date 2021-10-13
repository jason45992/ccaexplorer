import 'package:ccaexplorer/club/club_detail/club_detail.dart';
import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // new
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:ccaexplorer/app_theme.dart';
import 'package:ccaexplorer/register.dart';
// import 'src/event_details/event_detail.dart';
import 'club/club_join/club_join_form.dart';
import 'event_list/event_home_screen.dart';
import 'src/login/login.dart';
import 'package:ccaexplorer/pages/home_page.dart';
import 'package:ccaexplorer/club/club_list/club_list.dart';
import 'src/authentication_state.dart'; // new
import 'src/widgets.dart';
import 'authentication.dart';
import 'event_list/models/user_data_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common_method/common_method_authentication.dart';
import 'guest_book.dart';
import 'admin_image_upload/event_detail_admin.dart';
import 'admin/GridViewDemo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationState()),
        ChangeNotifierProvider(create: (_) => ApplicationGuestBookState()),
        ChangeNotifierProvider(create: (_) => ApplicationUserDetailState()),
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
      home: HomePage(),
      //home: ClubDetailPage(Club.generateClubs()[0]),
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
                Header(AuthenticationCommon().loginState.toString()),
                if (AuthenticationCommon().loginState ==
                    ApplicationLoginState.loggedIn) ...[
                  Header('Demo'),
                  UserDetail(
                      addUser: (String message) => appState.addUser(message),
                      userDetails: appState.userDetailList)
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
