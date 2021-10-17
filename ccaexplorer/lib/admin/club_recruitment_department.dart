import 'package:flutter/material.dart';
import 'admin_theme.dart';
import 'package:ccaexplorer/admin/admin_add_department.dart';
import 'add_department_position.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClubRecruitmentDepartment extends StatefulWidget {
  const ClubRecruitmentDepartment({Key? key}) : super(key: key);

  @override
  _ClubRecruitmentDepartmentState createState() =>
      _ClubRecruitmentDepartmentState();
}

class _ClubRecruitmentDepartmentState extends State<ClubRecruitmentDepartment> {
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('club_department')
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        // Do something with change
        setState(() {
          UserInformation();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            getAppBarUI(),
            const SizedBox(height: 10),
            UserInformation(),
          ],
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Text(
              'Department',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDepartment(),
                  ),
                );
              },
              icon: Icon(
                Icons.add,
                size: 40,
                color: Colors.yellow,
              ),
              label: Text("ADD", style: TextStyle(color: Colors.black87)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('club_department').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data['name']),
                    FlatButton(
                      textColor: Colors.grey,
                      child: Text(
                        'Edit',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DepartmentPosition()),
                        );
                      },
                    )
                  ],
                ),
                children: <Widget>[
                  positiondetail(
                    data['department_id'],
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget positiondetail(String eventid) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('club_role')
        .where('department_id', isEqualTo: eventid)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(
                  '${data['position']}- ${data['ECA_point']} ECA Point - (${data['Availability']})'),
            );
          }).toList(),
        );
      },
    );
  }
}
