class Club {
  String id;
  String bgImg;
  String icon;
  String name;
  String type;
  num score;
  num download;
  num review;
  String desc;
  String contact;
  List<String> imgs;
  Club(
    this.id,
    this.bgImg,
    this.icon,
    this.name,
    this.type,
    this.score,
    this.download,
    this.review,
    this.desc,
    this.contact,
    this.imgs,
  );

  static List<Club> generateClubs(String id, String logourl, String clubname,
      String category, String description) {
    return [
      Club(
        id,
        logourl,
        logourl,
        clubname,
        category,
        5.0,
        300,
        400,
        description,
        'Tel: 81234567',
        [
          'assets/club/album1.JPG',
          'assets/club/album2.JPG',
          'assets/club/album3.JPG',
        ],
      ),
    ];
  }
}
