import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'admin_theme.dart';

class AdminClubManagement extends StatefulWidget {
  @override
  _AdminClubManagementState createState() => _AdminClubManagementState();
}

class _AdminClubManagementState extends State<AdminClubManagement> {
  AnimationController? animationController;

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
          ],
        ),
      ),
    );
  }

  Widget getClubList() {
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
          height: 600,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                height: 80,
                child: GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AdminPublishedEvents(), //club profile
                    //     ),
                    //   );
                    // },
                    child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Color(0xFFE6E4E3),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 60,
                        height: 60,
                        child: Icon(FontAwesomeIcons.fileInvoice,
                            color: Color(0xffb0b4b8)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 27, left: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Club Profile',
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                height: 80,
                child: GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AdminPublishedEvents(), //club profile
                    //     ),
                    //   );
                    // },
                    child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Color(0xFFE6E4E3),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 60,
                        height: 60,
                        child: Icon(FontAwesomeIcons.users,
                            color: Color(0xffb0b4b8)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 27, left: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Memeber Management',
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                height: 80,
                child: GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AdminPublishedEvents(), //club profile
                    //     ),
                    //   );
                    // },
                    child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Color(0xFFE6E4E3),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 60,
                        height: 60,
                        child: Icon(FontAwesomeIcons.userPlus,
                            color: Color(0xffb0b4b8)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 27, left: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Club Recruiment',
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
              ),
            ],
          )),
    );
  }
}
