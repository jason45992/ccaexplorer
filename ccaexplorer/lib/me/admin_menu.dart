import 'package:ccaexplorer/admin/select_club.dart';
import 'package:flutter/material.dart';
import 'package:ccaexplorer/me/me_home.dart';

class RedeemConfirmationScreen extends StatelessWidget {
  final List<ClubDetails> clubs;

  RedeemConfirmationScreen(this.clubs, {Key? key}) : super(key: key);

  final List<String> entries = <String>[
    'Events',
    'Club Management',
    'Application List'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.85),
        body: Column(children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top + 100,
          ),
          SizedBox(
            height: 400,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                    height: 80,
                    child: GestureDetector(
                      onTap: () {
                        moveTo('${entries[index]}', context, clubs);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFFEDF0F2), width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Color(0xFF3A5160),
                        child: Center(
                            child: Text(
                          '${entries[index]}',
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.27,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: entries.length),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.close, color: Colors.white),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              primary: Color(0XFFCC541D), // <-- Button color
              onPrimary: Colors.red, // <-- Splash color
            ),
          )
        ]));
  }

  moveTo(String type, BuildContext context, List<ClubDetails> clubs) {
    if (type == 'Events') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminClubList(clubs, "events"), //club profile
        ),
      );
    } else if (type == 'Club Management') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminClubList(clubs, "cLubs"), //club profile
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AdminClubList(clubs, "applicaiton"), //club profile
        ),
      );
    }
  }
}
