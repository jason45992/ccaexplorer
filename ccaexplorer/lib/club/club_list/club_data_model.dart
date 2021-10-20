class ClubCategory {
  const ClubCategory({
    required this.name,
    required this.clubs,
  });
  final String name;
  final Club clubs;
}

class Club {
  const Club({
    required this.name,
    required this.image,
  });
  final String name;
  final String image;
}
