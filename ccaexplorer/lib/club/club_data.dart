import 'package:flutter/material.dart';

class ClubCategory {
  const ClubCategory({
    required this.name,
    required this.clubs,
  });
  final String name;
  final List<Club> clubs;
}

class Club {
  const Club({
    required this.name,
    required this.image,
  });
  final String name;
  final String image;
}

const clubCategories = [
  ClubCategory(
    name: 'Academic',
    clubs: [
      Club(
          name: 'Electrical and Electronic Engineering Club',
          image: 'assets/club/EEE.jpeg'),
      Club(name: 'Art, Design & Media Club', image: 'assets/club/ADM.png'),
      Club(
          name: 'Civil & Environmental Engineering Club',
          image: 'assets/club/CEE.jpeg'),
    ],
  ),
  ClubCategory(
    name: 'Culturals',
    clubs: [
      Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
    ],
  ),
  ClubCategory(
    name: 'Welfare',
    clubs: [
      Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
    ],
  ),
  ClubCategory(
    name: 'Sports',
    clubs: [
      Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
    ],
  ),
  ClubCategory(
    name: 'Arts',
    clubs: [
      Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
    ],
  ),
  ClubCategory(
    name: 'Religions',
    clubs: [
      Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
    ],
  ),
  ClubCategory(
    name: 'Interests',
    clubs: [
      Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
    ],
  ),
];
