import 'package:ccaexplorer/club/club_list/club_list.dart';
import 'package:ccaexplorer/home_event_list/event_home_screen.dart';
import 'package:ccaexplorer/me/me_home.dart';
import 'package:ccaexplorer/pages/club_page.dart';
import 'package:ccaexplorer/pages/me_page.dart';
import 'package:ccaexplorer/pages/timetable_page.dart';
import 'package:ccaexplorer/pages/event_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screen = [
    EventlHomeScreen(),
    ClubHomeScreen(),
    TimetablePage(),
    MeHome()
  ];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0
                  ? Color(0xFF3A5160)
                  : Colors.grey.withOpacity(0.8),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  color: _selectedIndex == 0
                      ? Color(0xFF3A5160)
                      : Colors.grey.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_view,
              color: _selectedIndex == 1
                  ? Color(0xFF3A5160)
                  : Colors.grey.withOpacity(0.8),
            ),
            title: Text(
              'Club',
              style: TextStyle(
                  color: _selectedIndex == 1
                      ? Color(0xFF3A5160)
                      : Colors.grey.withOpacity(0.8),
                  fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: _selectedIndex == 2
                  ? Color(0xFF3A5160)
                  : Colors.grey.withOpacity(0.8),
            ),
            title: Text(
              'Timetable',
              style: TextStyle(
                  color: _selectedIndex == 2
                      ? Color(0xFF3A5160)
                      : Colors.grey.withOpacity(0.8),
                  fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 3
                  ? Color(0xFF3A5160)
                  : Colors.grey.withOpacity(0.8),
            ),
            title: Text(
              'Me',
              style: TextStyle(
                  color: _selectedIndex == 3
                      ? Color(0xFF3A5160)
                      : Colors.grey.withOpacity(0.8),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
