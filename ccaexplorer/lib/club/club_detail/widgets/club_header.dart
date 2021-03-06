import 'package:ccaexplorer/club/club_detail/club_detail_data.dart';
import 'package:flutter/material.dart';

class ClubHeader extends StatelessWidget {
  final Club club;
  const ClubHeader(this.club, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Image.network(club.icon, width: 80),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  club.name,
                  maxLines: 2, // you can change it accordingly
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  club.type,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildIconText(
                      club.score.toString(),
                      Icons.star,
                      Colors.amber,
                    ),
                    const SizedBox(width: 30),
                    _buildIconText(
                      '${club.clubnum}',
                      Icons.people_alt_outlined,
                      Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIconText(String text, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 15,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
