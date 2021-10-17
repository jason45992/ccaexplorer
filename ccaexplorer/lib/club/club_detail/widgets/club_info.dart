import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:ccaexplorer/club/club_detail/widgets/club_contact.dart';
import 'package:ccaexplorer/club/club_detail/widgets/club_description.dart';
import 'package:ccaexplorer/club/club_detail/widgets/club_gallery.dart';
import 'package:ccaexplorer/club/club_detail/widgets/club_header.dart';
import 'package:flutter/material.dart';

class ClubInfo extends StatelessWidget {
  final Club club;
  const ClubInfo(this.club, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(children: [
          ClubHeader(club),
          ClubGallery(club),
          ClubDescription(club),
          ClubContact(club),
        ]),
      ),
    );
  }
}
