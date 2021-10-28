import 'package:ccaexplorer/club/club_list/club_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../src/authentication_state.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../src/widgets.dart';
import '../../common_method/common_method_authentication.dart';
import 'club_bloc.dart';

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
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.clubmembernum,
    required this.rating,
    required this.contact,
  });
  final String id;
  final String name;
  final String image;
  final String description;
  final String clubmembernum;
  final String rating;
  final String contact;
}

List categorylist = [
  'Academic',
  'Culturals',
  'Welfare',
  'Sports',
  'Arts',
  'Religions',
  'Interests'
];

class ApplicationClubDetailState extends ChangeNotifier {
  TabController? tabController;
  ScrollController scrollController = ScrollController();
  ApplicationClubDetailState() {
    init();
  }

  // event
  StreamSubscription<QuerySnapshot>? _clubDetailSubscription;
  List<TabCategory> _tabs = [];
  List<TabCategory> get tabs => _tabs;
  List<Item> _items = [];
  List<Item> get items => _items;
  List<Club> _clubs = [];
  List<Club> get clubs => _clubs;
  bool _listen = true;

  get club => Club(
      id: "",
      name: "",
      image: "",
      description: '',
      clubmembernum: '',
      rating: '',
      contact: '');

  //init applicaiton State
  Future<void> init() async {
    await Firebase.initializeApp();

    // event
    double offsetFrom = 0.0;
    double offsetTo = 0.0;
    _items = [];
    _clubs = [];
    _tabs = [];
    for (int i = 0; i < categorylist.length; i++) {
      String category = categorylist[i];
      _clubDetailSubscription = FirebaseFirestore.instance
          .collection('club')
          .where('category', isEqualTo: category)
          .snapshots()
          .listen((snapshot) {
        int i2 = 0;
        snapshot.docs.forEach((document) {
          FirebaseFirestore.instance
              .collection('file')
              .where('id', isEqualTo: document['logo_id'])
              .snapshots()
              .listen((event) {
            event.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('club_member')
                  .where('club_id', isEqualTo: document['id'])
                  .snapshots()
                  .listen((user) {
                if (i2 == 0) {
                  _items.add(Item(category: category, club: club));
                }

                _items.add(
                  Item(
                    category: category,
                    club: Club(
                        id: document['id'],
                        name: document['name'],
                        image: element['url'],
                        description: document['description'],
                        clubmembernum: user.size.toString(),
                        rating: document['club_score'].toString(),
                        contact: document['contact'].toString()),
                  ),
                );

                i2++;
                notifyListeners();
              });
            });
            notifyListeners();
          });
        });
        if (i > 0) {
          offsetFrom = _tabs[i - 1].clublength * clubHeight +
              _tabs[i - 1].offsetFrom +
              categoryHeight;
        }
        if (i < categorylist.length - 1) {
          offsetTo = offsetFrom + snapshot.size * clubHeight + categoryHeight;
        } else {
          offsetTo = double.infinity;
        }
        _tabs.add(TabCategory(
            category: category,
            selected: i == 0,
            offsetFrom: offsetFrom,
            offsetTo: offsetTo,
            clublength: snapshot.size));

        notifyListeners();
      });
    }

    notifyListeners();
  }

  void initi(TickerProvider ticker) async {
    tabController = TabController(vsync: ticker, length: categorylist.length);
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
      final condition = selected.category == tabs[i].category;
      tabs[i] = tabs[i].copyWith(condition);
      notifyListeners();
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












// const clubCategories = [
//   ClubCategory(
//     name: 'Academic',
//     clubs: [
//       Club(
//           name: 'Electrical and Electronic Engineering Club',
//           image: 'assets/club/EEE.jpeg'),
//       Club(name: 'Art, Design & Media Club', image: 'assets/club/ADM.png'),
//       Club(
//           name: 'Civil & Environmental Engineering Club',
//           image: 'assets/club/CEE.jpeg'),
//     ],
//   ),
//   ClubCategory(
//     name: 'Culturals',
//     clubs: [
//       Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
//     ],
//   ),
//   ClubCategory(
//     name: 'Welfare',
//     clubs: [
//       Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
//     ],
//   ),
//   ClubCategory(
//     name: 'Sports',
//     clubs: [
//       Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
//     ],
//   ),
//   ClubCategory(
//     name: 'Arts',
//     clubs: [
//       Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
//     ],
//   ),
//   ClubCategory(
//     name: 'Religions',
//     clubs: [
//       Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
//     ],
//   ),
//   ClubCategory(
//     name: 'Interests',
//     clubs: [
//       Club(name: 'Chinese Orchestra', image: 'assets/club/EEE.jpeg'),
//     ],
//   ),
// ];