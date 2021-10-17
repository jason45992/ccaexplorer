import 'dart:ui';
import 'package:ccaexplorer/admin/published_events.dart';
import 'package:ccaexplorer/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'admin_theme.dart';

class AdminClubList extends StatefulWidget {
  @override
  _AdminClubListState createState() => _AdminClubListState();
}

class _AdminClubListState extends State<AdminClubList> {
  AnimationController? animationController;
  List<HotelListData> publishedEventList = HotelListData.hotelList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AdminTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    getClubList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AdminTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Select Club',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  Widget getClubList() {
    final List<Map> entries = <Map>[
      {'name': 'Club Name1', 'matricNum': 'U12345678A'},
      {'name': 'Club Name2', 'matricNum': 'U12345678A'},
      {'name': 'Club Name3', 'matricNum': 'U12345678A'},
      {'name': 'Club Name4', 'matricNum': 'U12345678A'}
    ];
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 600,
        child: ListView.separated(
            padding: EdgeInsets.only(top: 10),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                height: 80,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminPublishedEvents(),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Color(0xFFE6E4E3),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 60,
                            height: 60,
                            child: Image.asset('assets/images/userImage.png'),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 27, left: 20),
                            child: Column(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${entries[index]['name']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: entries.length),
      ),
    );
  }
}
