import 'club_data.dart';

import 'package:ccaexplorer/club/club_list/club_data.dart';

const categoryHeight = 55.0;
const clubHeight = 100.0;

class TabCategory {
  const TabCategory({
    required this.category,
    required this.selected,
    required this.offsetFrom,
    required this.offsetTo,
    required this.clublength,
  });

  TabCategory copyWith(bool selected) => TabCategory(
        category: category,
        selected: selected,
        offsetFrom: offsetFrom,
        offsetTo: offsetTo,
        clublength: clublength,
      );

  final String category;
  final bool selected;
  final double offsetFrom;
  final double offsetTo;
  final int clublength;
}

class Item {
  const Item({required this.category, required this.club});
  final String category;
  final Club club;
}
