import 'club_data.dart';

import 'package:ccaexplorer/club/club_list/club_data.dart';

const categoryHeight = 55.0;
const clubHeight = 100.0;

// class ClubBloc with ChangeNotifier {
//   TabController? tabController;
//   ScrollController scrollController = ScrollController();
//   bool _listen = true;
//   List clubCategories = [];

//   get club => Club(name: "", image: "");

//   void init(TickerProvider ticker) async {
//     tabController = TabController(vsync: ticker, length: clubCategories.length);

//     scrollController.addListener(_onScrollListener);
//   }

//   void _onScrollListener() {
//     if (_listen) {
//       for (int i = 0; i < tabs.length; i++) {
//         final tab = tabs[i];
//         if (scrollController.offset >= tab.offsetFrom &&
//             scrollController.offset <= tab.offsetTo &&
//             !tab.selected) {
//           onCategorySelected(i, animationRequired: false);

//           tabController?.animateTo(i);
//           break;
//         }
//       }
//     }
//   }

//   void onCategorySelected(int index, {bool animationRequired = true}) async {

//     final selected = tabs[index];
//     for (int i = 0; i < tabs.length; i++) {
//       final condition = selected.category == tabs[i].category;
//       tabs[i] = tabs[i].copyWith(condition);
//     }
//     notifyListeners();

//     if (animationRequired) {
//       _listen = false;
//       await scrollController.animateTo(
//         selected.offsetFrom,
//         duration: const Duration(milliseconds: 50),
//         curve: Curves.linear,
//       );
//       _listen = true;
//     }
//   }

//   void dispose() {
//     scrollController.removeListener(_onScrollListener);
//     scrollController.dispose();
//     tabController?.dispose();
//     super.dispose();
//   }
// }

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
