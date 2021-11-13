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
  Club({
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
  String clubmembernum;
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

Map<String, int> categoryCount = {};

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
  List<ClubMemberNumberList> cLubmemnoList = [];

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
                      clubmembernum: '0',
                      rating: document['club_score'].toString(),
                      contact: document['contact'].toString()),
                ),
              );

              i2++;
              notifyListeners();
            });
            for (int i = 0; i < _items.length; i++) {
              FirebaseFirestore.instance
                  .collection('club_member')
                  .where('club_id', isEqualTo: _items[i].club.id)
                  .snapshots()
                  .listen((user) {
                cLubmemnoList.add(
                  ClubMemberNumberList(
                      id: _items[i].club.id,
                      clubmemberno: user.size.toString()),
                );
                _items.forEach((clubDetail) {
                  cLubmemnoList.forEach((cLubmemnodetail) {
                    if (cLubmemnodetail.id == clubDetail.club.id) {
                      clubDetail.club.clubmembernum =
                          cLubmemnodetail.clubmemberno;

                      notifyListeners();
                    }
                  });
                });
              });
            }
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

  filterByKeyword(String key) {
    if (key.isNotEmpty) {
      this._items = this
          ._items
          .where((i) =>
              i.club.name.toLowerCase().contains(key.toLowerCase()) ||
              i.club.name.isEmpty)
          .toList();

      initCategoryCount();
      for (Item i in this._items) {
        categoryCount[i.category] = categoryCount[i.category]! + 1;
      }

      this._items =
          this._items.where((i) => categoryCount[i.category]! > 1).toList();
    }
  }

  initCategoryCount() {
    categoryCount = {
      'Academic': 0,
      'Culturals': 0,
      'Welfare': 0,
      'Sports': 0,
      'Arts': 0,
      'Religions': 0,
      'Interests': 0
    };
  }
}

class ClubMemberNumberList {
  ClubMemberNumberList({required this.id, required this.clubmemberno});
  final String id;
  final String clubmemberno;
}
