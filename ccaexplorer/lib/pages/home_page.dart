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
  List<Widget> _screen = [EventPage(), ClubPage(), TimetablePage(), MePage()];

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
              color: _selectedIndex == 0 ? Colors.purple : Colors.grey,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: _selectedIndex == 0 ? Colors.purple : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_view,
              color: _selectedIndex == 1 ? Colors.purple : Colors.grey,
            ),
            title: Text(
              'Club',
              style: TextStyle(
                color: _selectedIndex == 1 ? Colors.purple : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: _selectedIndex == 2 ? Colors.purple : Colors.grey,
            ),
            title: Text(
              'Timetable',
              style: TextStyle(
                color: _selectedIndex == 2 ? Colors.purple : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 3 ? Colors.purple : Colors.grey,
            ),
            title: Text(
              'Me',
              style: TextStyle(
                color: _selectedIndex == 3 ? Colors.purple : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}