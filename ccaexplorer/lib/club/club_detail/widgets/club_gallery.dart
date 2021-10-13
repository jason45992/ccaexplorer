import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:flutter/material.dart';

class ClubGallery extends StatelessWidget {
  final Club club;
  const ClubGallery(this.club, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Club Album',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => SizedBox(
                    width: 250,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          club.imgs[index],
                          fit: BoxFit.cover,
                        )),
                  ),
              separatorBuilder: (_, index) => const SizedBox(width: 15),
              itemCount: club.imgs.length),
        )
      ]),
    );
  }
}
