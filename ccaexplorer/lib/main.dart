import 'package:ccaexplorer/club/club_list/club_data.dart';
import 'package:ccaexplorer/introduction_animation/introduction_animation_screen.dart';
import 'package:ccaexplorer/home_event_list/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'introduction_animation/introduction_animation_screen.dart';
import 'authentication.dart';
import 'home_event_list/models/user_data_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'guest_book.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationState()),
        ChangeNotifierProvider(create: (_) => ApplicationGuestBookState()),
        ChangeNotifierProvider(create: (_) => ApplicationUserDetailState()),
        ChangeNotifierProvider(create: (_) => ApplicationEventDetailState()),
        ChangeNotifierProvider(create: (_) => ApplicationClubDetailState()),
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
      home: IntroductionAnimationScreen(),
      // home: HomePage(),
<<<<<<< HEAD
      home: EditMember(), // home: HomePage(),
      //home: ClubDetailPage(Club.generateClubs()[0]),
=======
>>>>>>> caf0baf90e1e332df016124eba0b93acdf39bdff
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
