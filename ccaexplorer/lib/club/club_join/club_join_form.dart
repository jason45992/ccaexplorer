import 'package:flutter/material.dart';
import 'package:ccaexplorer/club/event_app_theme.dart';

class ClubJoinPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return ClubJoinPageState();
  }
}

class ClubJoinPageState extends State<ClubJoinPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
        backgroundColor: Colors.white,
        title: Text(
          'Join Club',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.27,
            color: EventAppTheme.darkerText,
          ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: EventAppTheme.darkerText,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Club Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'EEE Club',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.6),
                ),
              )
            ]),
            const SizedBox(height: 30),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Departments',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton(
                dropdownColor: Colors.white,
                isExpanded: true,
                elevation: 1,
                value: selected1,
                items: Department.map(
                    (e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (String? val) {
                  setState(() {
                    if (val != null) {
                      selected1 = val;
                    }
                  });
                },
              ),
            ]),
            const SizedBox(height: 30),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Positions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton(
                isExpanded: true,
                dropdownColor: Colors.white,
                elevation: 1,
                value: selected2,
                items: Position.map(
                    (e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (String? val) {
                  setState(() {
                    if (val != null) {
                      selected2 = val;
                    }
                  });
                },
              ),
            ]),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 6,
                  shadowColor: Colors.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Matric No.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Contact No.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 40),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dylan Wong',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'U19201234',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'dylanwong@e.ntu.edu.sg',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '81234567',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            SizedBox(
              width: double.maxFinite,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  shadowColor: Colors.purple.withOpacity(0.4),
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Application submitted successfully.",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
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

  var selected1 = 'Student Development';
  final Department = [
    'Student Development',
    'Branding',
    'Business',
    'Studentlife',
    'Ops Support',
    'Relations',
    'Finance'
  ];
  var selected2 = 'Group Leader';
  final Position = ['Group Leader', 'Group Member'];
}
