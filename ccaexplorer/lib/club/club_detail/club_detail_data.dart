class Club {
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

  static List<Club> generateClubs() {
    return [
      Club(
        'assets/club/ADM.png',
        'assets/club/ADM.png',
        'ADM',
        'Academic',
        5.0,
        300,
        400,
        'A student initiated group specifically for the ADM community, this group is a platform for current and graduated ADMers to network and communicate. For the official NTU ADM Facebook Page, please visit https://www.facebook.com/ntuadm. Launched in year2011, the group was founded by Yao Khuan for FOC members but swiftly like billy-o expanded to include all ADM members alike.A student initiated group specifically for the ADM community, this group is a platform for current and graduated ADMers to network and communicate. For the official NTU ADM Facebook Page, please visit https://www.facebook.com/ntuadm. Launched in year2011, the group was founded by Yao Khuan for FOC members but swiftly like billy-o expanded to include all ADM members alike.',
        'Tel: 81234567',
        [
          'assets/club/album1.JPG',
          'assets/club/album2.JPG',
          'assets/club/album3.JPG',
        ],
      ),
      Club(
        'assets/club/EEE.jpeg',
        'assets/club/EEE.jpeg',
        'EEE',
        'Academic',
        4.0,
        500,
        600,
        'Itseeeclub',
        '81234567',
        [
          'assets/club/album1.JPG',
          'assets/club/album2.JPG',
          'assets/club/album3.JPG',
        ],
      )
    ];
  }
}
