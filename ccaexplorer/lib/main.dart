import 'package:ccaexplorer/me/me_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // new
import 'src/authentication_state.dart'; // new
import 'src/widgets.dart';
import 'authentication.dart';
import 'event_list/models/user_data_model.dart';
import 'me/admin_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common_method/common_method_authentication.dart';
import 'guest_book.dart';
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
              highlightColor: Colors.deepPurple,
            ),
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GridViewDemo(title: 'Grid View Demo'),
      // home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Meetup'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/images/codelab.png'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, 'October 30'),
          const IconAndDetail(Icons.location_city, 'San Francisco'),
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
