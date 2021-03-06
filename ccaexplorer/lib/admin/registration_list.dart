import 'dart:ui';
import 'package:ccaexplorer/admin/participant_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'admin_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ccaexplorer/admin/published_events.dart';

class AdminRegistrationList extends StatefulWidget {
  final EventDetails event;
  AdminRegistrationList(this.event, {Key? key}) : super(key: key);

  @override
  _AdminRegistrationListState createState() =>
      _AdminRegistrationListState(this.event);
}

class _AdminRegistrationListState extends State<AdminRegistrationList> {
  AnimationController? animationController;
  final EventDetails event;
  final _controller = TextEditingController();

  String searchKey = "";
  List<EventApplicantDetails> _eventApplicantlList = [];
  _AdminRegistrationListState(this.event);

  @override
  void initState() {
    super.initState();
    getData();
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
                    getSearchBarUI(),
                    // getfunctionBar(),
                    getUserList(),
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
            top: MediaQuery.of(context).padding.top, left: 8, right: 100),
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
                    Navigator.pop(context, false);
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
                  'Registration List',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getUserList() {
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
                          child: _eventApplicantlList[index]
                                  .profilePicUrl
                                  .isNotEmpty
                              ? Image.network(
                                  _eventApplicantlList[index].profilePicUrl)
                              : Image.asset('assets/images/userImage.png'),
                        ),
                        Container(
                          width: 110,
                          padding: const EdgeInsets.only(top: 20, left: 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${_eventApplicantlList[index].name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                  )),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${_eventApplicantlList[index].matricNum}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          height: 30,
                          width: 60,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white24,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(100.0)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AdminParticipantProfile(
                                            _eventApplicantlList[index]),
                                  ),
                                );
                              },
                              child: Icon(FontAwesomeIcons.solidAddressCard,
                                  color: Colors.brown.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: _eventApplicantlList.length),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AdminTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: _controller,
                    onTap: () {
                      getData();
                      _controller.clear();
                    },
                    onChanged: (String txt) {
                      searchKey = txt;
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  search();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 15,
                      color: AdminTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getfunctionBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 9, left: 16, right: 16),
      child: Row(children: <Widget>[
        SizedBox(
          width: 235,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          height: 30,
          width: 60,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              onTap: () {
                print("click");
              },
              child: Icon(FontAwesomeIcons.phoneAlt, color: Colors.red),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          height: 30,
          width: 60,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              onTap: () {
                print("click");
              },
              child: Icon(FontAwesomeIcons.solidEnvelope, color: Colors.red),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> getData() async {
    FirebaseFirestore.instance
        .collection('event_application')
        .where('event_id', isEqualTo: event.id)
        .snapshots()
        .listen((data) {
      _eventApplicantlList = [];
      data.docs.forEach((applicaiton) {
        FirebaseFirestore.instance
            .collection('useracc')
            .where('userid', isEqualTo: applicaiton.get('user_id'))
            .snapshots()
            .listen((data) {
          data.docs.forEach((user) {
            _eventApplicantlList.add(EventApplicantDetails(
                name: user.get('Name'),
                matricNum: user.get('Matric_no'),
                email: user.get('NTUEmail'),
                phone: user.get('phone').toString(),
                remarks: applicaiton.get('remark'),
                profilePicUrl: user.get('profile_pic_id')));
          });
          setState(() {});
        });
      });
    });
  }

  search() {
    _eventApplicantlList = _eventApplicantlList
        .where((i) =>
            i.matricNum.toLowerCase().contains(searchKey.toLowerCase()) ||
            i.name.toLowerCase().contains(searchKey.toLowerCase()))
        .toList();
    if (_eventApplicantlList.length > 0) {
      setState(() {});
    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        getData();
        _controller.clear();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No result found"),
      content: Text("Please use other keywords."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class EventApplicantDetails {
  EventApplicantDetails(
      {required this.name,
      required this.matricNum,
      required this.email,
      required this.phone,
      required this.remarks,
      required this.profilePicUrl});
  final String name;
  final String matricNum;
  final String email;
  final String phone;
  final String remarks;
  final String profilePicUrl;
}
