import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:ccaexplorer/club/club_join/club_join_form.dart';
import 'package:ccaexplorer/club/event_app_theme.dart';
import 'package:flutter/material.dart';

class ClubContact extends StatelessWidget {
  final Club club;
  const ClubContact(this.club, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.maxFinite,
            child: Text(
              club.contact,
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: double.maxFinite,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClubJoinPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 6,
                shadowColor: EventAppTheme.grey.withOpacity(0.4),
                primary: EventAppTheme.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Join Club',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
