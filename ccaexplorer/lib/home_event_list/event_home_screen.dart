import 'package:ccaexplorer/home_event_list/banner_list_view.dart';
import 'package:ccaexplorer/home_event_list/models/event_data_model.dart';
import 'package:ccaexplorer/home_event_list/event_list_view.dart';
import 'package:ccaexplorer/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'event_app_theme.dart';

class EventlHomeScreen extends StatefulWidget {
  @override
  _EventlHomeScreenState createState() => _EventlHomeScreenState();
}

class _EventlHomeScreenState extends State<EventlHomeScreen> {
  CategoryType categoryType = CategoryType.all;
  List<EventDetails> tempEventList = [];

  @override
  Widget build(BuildContext context) {
    // ApplicationEventDetailState().init();
    return Consumer<ApplicationEventDetailState>(
        builder: (context, appState, _) => SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: EventAppTheme.nearlyWhite,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        // getAppBarUI(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: <Widget>[
                                  getSearchBarUI(appState, context),
                                  getBannerUI(appState),
                                  Flexible(
                                    child: getEventListUI(appState),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  Widget getBannerUI(ApplicationEventDetailState appState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BannerListView(
          callBack: () {
            moveTo();
          },
          appState: appState,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 130, right: 16),
          child: Text(
            'Upcoming Events',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 0.27,
              color: EventAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(
                  CategoryType.all, categoryType == CategoryType.all, appState),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(CategoryType.latest,
                  categoryType == CategoryType.latest, appState),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(CategoryType.myClub,
                  categoryType == CategoryType.myClub, appState),
            ],
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
      ],
    );
  }

  Widget getEventListUI(ApplicationEventDetailState appState) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${appState.eventDetailList.length} results found',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 0.27,
              color: EventAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: EventListView(
              callBack: () {
                // moveTo();
              },
              appState: appState,
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    // Navigator.push<dynamic>(
    //   context,
    //   MaterialPageRoute<dynamic>(
    //     builder: (BuildContext context) => CourseInfoScreen(),
    //   ),
    // );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected,
      ApplicationEventDetailState appState) {
    String txt = '';
    if (CategoryType.all == categoryTypeData) {
      txt = 'ALL';
    } else if (CategoryType.latest == categoryTypeData) {
      txt = 'Latest';
    } else if (CategoryType.myClub == categoryTypeData) {
      txt = 'My Club';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? EventAppTheme.grey : EventAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(color: EventAppTheme.grey)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
                updateListByCategory(
                    categoryType, appState, this.tempEventList);
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? EventAppTheme.nearlyWhite
                        : EventAppTheme.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI(
      ApplicationEventDetailState appState, BuildContext context) {
    TextEditingController searchController = TextEditingController();
    void stateSetter() {
      setState(() {});
      print("Set State triggered!");
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  border: Border.all(color: HexColor('#B9BABC')),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          controller: searchController,
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: EventAppTheme.grey,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for events and activities',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onTap: () {
                            appState.init();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 60,
                        height: 40,
                        child: new IconButton(
                          icon: new Icon(
                            Icons.search,
                            color: HexColor('#B9BABC'),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            updateListByKeyWord(searchController.text, appState,
                                context, stateSetter, this.tempEventList);
                            setState(() {});
                          },
                        ))
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

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: EventAppTheme.grey,
                  ),
                ),
                Text(
                  '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: EventAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

updateListByKeyWord(
    String keyWord,
    ApplicationEventDetailState appState,
    BuildContext context,
    VoidCallback stateSetter,
    List<EventDetails> tempEventList) {
  // appState.init();
  // Future.delayed(const Duration(milliseconds: 250), () {
  if (keyWord.isNotEmpty) {
    List<EventDetails> tempList = appState.eventDetailList
        .where((map) =>
            map.eventTitle.toLowerCase().contains(keyWord.toLowerCase()))
        .toList();
    if (tempList.length == 0) {
      showAlertDialog(context);
    } else {
      appState.setEventDetailList = tempList;
      tempEventList = tempList;
    }
  } else {
    appState.init();
    Future.delayed(const Duration(milliseconds: 5000), () {
      tempEventList = appState.eventDetailList;
      print(tempEventList.length);
    });
  }
  // stateSetter();
  // print("executed");
  // });
}

updateListByCategory(CategoryType categoryType,
    ApplicationEventDetailState appState, List<EventDetails> tempEventList) {
  if (categoryType == CategoryType.all) {
    appState.init();
  } else if (categoryType == CategoryType.latest) {
    List<EventDetails> tempList = tempEventList
        .where((map) => ((new DateFormat("yyyy-MM-dd hh:mm:ss")
                .parse(map.datetime)
                .isAfter(DateTime.now())) &&
            (new DateFormat("yyyy-MM-dd hh:mm:ss")
                .parse(map.datetime)
                .isBefore(DateTime.now().add(Duration(days: 14, hours: 23))))))
        .toList();
    if (tempList.length > 0) {
      appState.setEventDetailList = tempList;
    }
  } else {
    //my club
    List<String> clubList = ["student union", "art"];
    List<EventDetails> tempList = appState.eventDetailList
        .where((map) => (clubList.contains(map.club.toLowerCase())))
        .toList();
    if (tempList.length > 0) {
      appState.setEventDetailList = tempList;
    }
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
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

enum CategoryType {
  all,
  latest,
  myClub,
}
