class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/event_list/banner1.jpeg',
      title: 'Event Name',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/event_list/banner2.jpeg',
      title: 'Event Name',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Category(
      imagePath: 'assets/event_list/banner3.jpeg',
      title: 'Event Name',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/event_list/banner4.jpeg',
      title: 'Event Name',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/event_list/poster1.jpeg',
      title: 'Jazzy Night',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/event_list/poster2.jpeg',
      title: 'Sport Event',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/event_list/poster3.jpeg',
      title: 'Football',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/event_list/poster4.jpeg',
      title: 'New Year',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}
