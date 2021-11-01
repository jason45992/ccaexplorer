import 'package:ccaexplorer/club/club_detail/widgets/club_contact.dart';
import 'package:ccaexplorer/club/club_detail/widgets/club_description.dart';
import 'package:ccaexplorer/club/club_detail/widgets/club_gallery.dart';
import 'package:ccaexplorer/club/club_detail/widgets/club_header.dart';
import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:flutter/material.dart';

import '../event_app_theme.dart';

class ClubDetailPage extends StatelessWidget {
  final Club club;
  const ClubDetailPage(this.club, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
        backgroundColor: Colors.white,
        title: Text(
          'Club Details',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.27,
            color: EventAppTheme.darkerText,
          ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: EventAppTheme.darkerText,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(children: [
              // ClubDetailInformation(
              //   club,
              //   clubid: club.clubnum,
              // ),
              ClubHeader(club),
              ClubGallery(club),
              ClubDescription(club),
              ClubContact(club),
            ]),
          ),
        ),
      ),
    );
  }
}
