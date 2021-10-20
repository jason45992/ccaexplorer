import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ClubDescription extends StatelessWidget {
  final Club club;
  const ClubDescription(this.club, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(25),
        child: Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Club Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.maxFinite,
            child: ReadMoreText(
              club.desc,
              trimLines: 3,
              colorClickableText: EventAppTheme.nearlyBlack,
              trimMode: TrimMode.Line,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                height: 1.5,
              ),
              trimCollapsedText: 'more',
              trimExpandedText: 'less',
            ),
          )
        ])));
  }
}
