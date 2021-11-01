import 'package:ccaexplorer/club/club_detail/club_detail.dart';
import 'package:ccaexplorer/club/club_list/club_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ccaexplorer/home_event_list/event_app_theme.dart';
import 'package:ccaexplorer/club/club_detail/club_detail_data.dart' as Detail;
import 'package:ccaexplorer/main.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'club_data.dart';

class ClubHomeScreen extends StatefulWidget {
  const ClubHomeScreen({Key? key}) : super(key: key);

  @override
  _ClubHomeScreenState createState() => _ClubHomeScreenState();
}

class _ClubHomeScreenState extends State<ClubHomeScreen>
    with SingleTickerProviderStateMixin {
  ApplicationClubDetailState _bloc = ApplicationClubDetailState();
  void initState() {
    _bloc.initi(this);

    super.initState();
  }

  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  List category = [
    'Academic',
    'Culturals',
    'Welfare',
    'Sports',
    'Arts',
    'Religions',
    'Interests'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _bloc,
          builder: (_, __) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Colors.white,
                  height: 60,
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'CCA and Clubs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            letterSpacing: 0.27,
                            color: EventAppTheme.darkerText,
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: getSearchBarUI(),
              ),
              Builder(builder: (BuildContext context) {
                if (_bloc.tabs.length != 7) {
                  return CircularProgressIndicator();
                } else {
                  return Container(
                    height: 45,
                    child: TabBar(
                      onTap: _bloc.onCategorySelected,
                      controller: _bloc.tabController,
                      indicatorWeight: 0.1,
                      isScrollable: true,
                      tabs: _bloc.tabs.map((e) => _TabWidget(e)).toList(),
                    ),
                  );
                }
              }),
              Expanded(
                child: ListView.builder(
                  controller: _bloc.scrollController,
                  itemCount: _bloc.items.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final item = _bloc.items[index];
                    if (item.club.name == '') {
                      return _CategoryItem1(item.category);
                    } else {
                      return _ClubItem1(item.club, item.category);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollTab extends StatelessWidget {
  const ScrollTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _TabWidget extends StatelessWidget {
  const _TabWidget(this.tabCategory);
  final TabCategory tabCategory;

  Widget build(BuildContext context) {
    final selected = tabCategory.selected;
    return Opacity(
      opacity: selected ? 1 : 0.5,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: selected ? EventAppTheme.grey : Colors.transparent,
        shadowColor: EventAppTheme.grey.withOpacity(0.7),
        elevation: selected ? 3 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            tabCategory.category,
            style: TextStyle(
              color: selected ? Colors.white : EventAppTheme.grey,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryItem1 extends StatelessWidget {
  const _CategoryItem1(this.category);
  final String category;

  Widget build(BuildContext context) {
    return Container(
      height: categoryHeight,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Text(
        category,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.27,
          color: EventAppTheme.darkerText,
        ),
      ),
    );
  }
}

class _ClubItem1 extends StatelessWidget {
  const _ClubItem1(this.club, this.category);
  final Club club;
  final String category;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 400,
        height: clubHeight,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClubDetailPage(Detail.Club.generateClubs(
                    club.id,
                    club.image,
                    club.name,
                    category,
                    club.description,
                    club.clubmembernum,
                    club.rating,
                    club.contact,
                    false)[0]),
              ),
            );
          },
          child: Card(
            elevation: 20,
            shadowColor: Colors.black54.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(club.image),
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    club.name,
                    maxLines: 3,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      letterSpacing: 0.27,
                      color: EventAppTheme.darkerText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getSearchBarUI() {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 20, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 350,
          height: 64,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: HexColor('#F8FAFB'),
                border: Border.all(color: HexColor('#B9BABC')),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.w100,
                          fontSize: 16,
                          color: EventAppTheme.nearlyBlue,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Search for CCA and Clubs',
                          border: InputBorder.none,
                          helperStyle: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        onEditingComplete: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(Icons.search, color: HexColor('#B9BABC')),
                  )
                ],
              ),
            ),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        )
      ],
    ),
  );
}

// class SingleClubDetails extends StatelessWidget {
//   const SingleClubDetails({Key? key, required this.category}) : super(key: key);
//   final String category;
//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
//         .collection('club')
//         .where('category', isEqualTo: category)
//         .snapshots();

//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("");
//         }

//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//             width: 400,
//             child: ListView(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;

//                 return FinalWidget(
//                   id: data['logo_id'],
//                   name: data['name'],
//                   description: data['description'],
//                   category: data['category'],
//                 );
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class FinalWidget extends StatelessWidget {
//   const FinalWidget(
//       {Key? key,
//       required this.id,
//       required this.name,
//       required this.description,
//       required this.category})
//       : super(key: key);
//   final String id;
//   final String name;
//   final String description;
//   final String category;

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
//         .collection('file')
//         .where('id', isEqualTo: id)
//         .snapshots();
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("");
//         }

//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//             width: 400,
//             child: ListView(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;

//                 return _ClubItem(
//                   Club(image: data['url'], name: name),
//                   description,
//                   category,
//                 );
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
