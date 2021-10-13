import 'package:flutter/material.dart';
import 'package:ccaexplorer/club/club_list/club_data.dart';

const categoryHeight = 55.0;
const clubHeight = 100.0;

class ClubBloc with ChangeNotifier {
  List<TabCategory> tabs = [];
  List<Item> items = [];
  TabController? tabController;
  ScrollController scrollController = ScrollController();
  bool _listen = true;

  get club => Club(name: "", image: "");

  void init(TickerProvider ticker) {
    tabController = TabController(vsync: ticker, length: clubCategories.length);

    double offsetFrom = 0.0;
    double offsetTo = 0.0;

    for (int i = 0; i < clubCategories.length; i++) {
      final category = clubCategories[i];

      if (i > 0) {
        offsetFrom += clubCategories[i - 1].clubs.length * clubHeight;
      }
      if (i < clubCategories.length - 1) {
        offsetTo = offsetFrom + clubCategories[i + 1].clubs.length * clubHeight;
      } else {
        offsetTo = double.infinity;
      }

      tabs.add(TabCategory(
        category: category,
        selected: (i == 0),
        offsetFrom: categoryHeight * i + offsetFrom,
        offsetTo: offsetTo,
      ));
      items.add(Item(category: category, club: club));
      for (int j = 0; j < category.clubs.length; j++) {
        final club = category.clubs[j];
        items.add(Item(category: category, club: club));
      }
    }

    scrollController.addListener(_onScrollListener);
  }

  void _onScrollListener() {
    if (_listen) {
      for (int i = 0; i < tabs.length; i++) {
        final tab = tabs[i];
        if (scrollController.offset >= tab.offsetFrom &&
            scrollController.offset <= tab.offsetTo &&
            !tab.selected) {
          onCategorySelected(i, animationRequired: false);
          tabController?.animateTo(i);
          break;
        }
      }
    }
  }

  void onCategorySelected(int index, {bool animationRequired = true}) async {
    final selected = tabs[index];
    for (int i = 0; i < tabs.length; i++) {
      final condition = selected.category.name == tabs[i].category.name;
      tabs[i] = tabs[i].copyWith(condition);
    }
    notifyListeners();

    if (animationRequired) {
      _listen = false;
      await scrollController.animateTo(
        selected.offsetFrom,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
      _listen = true;
    }
  }

  void dispose() {
    scrollController.removeListener(_onScrollListener);
    scrollController.dispose();
    tabController?.dispose();
    super.dispose();
  }
}

class TabCategory {
  const TabCategory({
    required this.category,
    required this.selected,
    required this.offsetFrom,
    required this.offsetTo,
  });

  TabCategory copyWith(bool selected) => TabCategory(
        category: category,
        selected: selected,
        offsetFrom: offsetFrom,
        offsetTo: offsetTo,
      );

  final ClubCategory category;
  final bool selected;
  final double offsetFrom;
  final double offsetTo;
}

class Item {
  const Item({required this.category, required this.club});
  final ClubCategory category;
  final Club club;
  bool isCategory() {
    if (category.clubs.length == 0) {
      return true;
    } else {
      return false;
    }
  }
}
