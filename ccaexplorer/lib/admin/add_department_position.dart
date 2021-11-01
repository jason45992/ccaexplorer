import 'package:flutter/material.dart';
import 'admin_theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:spinner_input/spinner_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentPosition extends StatefulWidget {
  final departmentid;
  const DepartmentPosition({Key? key, @required this.departmentid})
      : super(key: key);

  @override
  _DepartmentPositionState createState() => _DepartmentPositionState();
}

class _DepartmentPositionState extends State<DepartmentPosition> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  final departmentnameInputController = TextEditingController();
  double availability = 1;
  double ecapoint = 1;

  List<ClubRole> clubrolepositonList = [];
  String departmentName = '';

  Future<void> deletedata() async {
    CollectionReference _clubDepartmentcollectionRef =
        FirebaseFirestore.instance.collection('club_department');
    _clubDepartmentcollectionRef.doc(widget.departmentid).delete();
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_role');

    _clubRolecollectionRef
        .where('department_id', isEqualTo: widget.departmentid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _clubRolecollectionRef.doc(element['id']).delete();
      });
    });
  }

  Future<void> getdata() async {
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_role');

    _clubRolecollectionRef
        .where('department_id', isEqualTo: widget.departmentid)
        .snapshots()
        .listen((event) {
      clubrolepositonList = [];
      event.docs.forEach((element) {
        clubrolepositonList.add(
          ClubRole(
              availability: element['Availability'],
              ecapoint: element['ECA_point'],
              position: element['position'],
              id: element['id']),
        );
      });
      setState(() {});
    });

    CollectionReference _clubDepartmentcollectionRef =
        FirebaseFirestore.instance.collection('club_department');

    _clubDepartmentcollectionRef
        .where('department_id', isEqualTo: widget.departmentid)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        departmentName = element['name'];
        setState(() {
          departmentnameInputController.text = element['name'];
        });
      });
    });
  }

  Future<void> updatedata() async {
    CollectionReference _clubDepartmentcollectionRef =
        FirebaseFirestore.instance.collection('club_department');
    _clubDepartmentcollectionRef
      ..doc(widget.departmentid)
          .update({'name': departmentnameInputController.text});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          body: Column(
            children: [
              getAppBarUI(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  children: [
                    getDepartmentName(),
                    const SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () {
                        updatedata();
                      },
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Text('Update Department Name'),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: clubrolepositonList.length,
                          itemBuilder: (context, index) {
                            return positionModify(
                              clubrolepositonList[index].position,
                              clubrolepositonList[index].ecapoint,
                              clubrolepositonList[index].availability,
                              index + 1,
                              clubrolepositonList[index].id,
                            );
                          }),
                    ),
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
            Container(
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 0),
            IconButton(
              onPressed: () {
                showAlertDialog3(context);
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog3(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        deletedata();
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Confirm Delete?",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [
        cancelButton,
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

  Widget getDepartmentName() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: Text(
              'Department Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Container(
          child: TextFormField(
            controller: departmentnameInputController,
            decoration: InputDecoration(
              labelText: 'Change your department name here',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        )
      ],
    );
  }

  Widget positionModify(
      String position, double ecapoint, double avalability, int i, String id) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        getposition(position, i, id),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getEcaPoint(ecapoint),
            getAvaibility(avalability),
          ],
        ),
      ],
    );
  }

  Widget getposition(String positionName, int i, String id) {
    final positionInputController = TextEditingController();

    positionInputController.text = positionName;

    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                child: Text(
                  'Position $i',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPositionPage(
                      clubroleid: id,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.edit),
            )
          ],
        ),
        Container(
          child: TextField(
            enabled: false,
            controller: positionInputController,
            decoration: InputDecoration(
              hintText: 'Enter a position',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        )
      ],
    );
  }

  Widget getEcaPoint(double decapoint) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(children: [
        const SizedBox(height: 10),
        Text(
          'ECA Point',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            decapoint.toInt().toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ]),
    );
  }

  Widget getAvaibility(double dgetAvaibility) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(children: [
        const SizedBox(height: 10),
        Text(
          'Availability',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            dgetAvaibility.toInt().toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ]),
    );
  }
}

class ClubRole {
  ClubRole({
    required this.availability,
    required this.ecapoint,
    required this.position,
    required this.id,
  });
  final double availability;
  final double ecapoint;
  final String position;
  final String id;
}

class EditPositionPage extends StatefulWidget {
  final clubroleid;
  const EditPositionPage({Key? key, @required this.clubroleid})
      : super(key: key);

  @override
  _EditPositionPageState createState() => _EditPositionPageState();
}

class _EditPositionPageState extends State<EditPositionPage> {
  final positionnameInputController = TextEditingController();

  Future<void> getdata() async {
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_role');
    _clubRolecollectionRef
        .where('id', isEqualTo: widget.clubroleid)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        setState(() {
          positionnameInputController.text = element['position'];
          ecapoint = element['ECA_point'];
          avaibility = element['Availability'];
        });
      });
    });
  }

  Future<void> deletedata() async {
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_role');
    _clubRolecollectionRef.doc(widget.clubroleid).delete();
  }

  Future<void> updatedata() async {
    print(avaibility);
    print(ecapoint);
    CollectionReference _clubRolecollectionRef =
        FirebaseFirestore.instance.collection('club_role');
    _clubRolecollectionRef.doc(widget.clubroleid).update({
      'position': positionnameInputController.text,
      'ECA_point': ecapoint,
      'Availability': avaibility,
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            getAppBarUI(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: positionnameInputController,
                    decoration: InputDecoration(
                      labelText: 'Change your position name here',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getEcaPoint(),
                      getAvaibility(),
                    ],
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                updatedata();
                showAlertDialog(context);
              },
              color: Colors.grey,
              textColor: Colors.white,
              child: Text('Update'),
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
        "Updated successfully.",
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

  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        deletedata();
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Confirm Delete?",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: [
        cancelButton,
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
              'Edit Position',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                showAlertDialog2(context);
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }

  double ecapoint = 1;
  Widget getEcaPoint() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(children: [
        const SizedBox(height: 30),
        Text(
          'ECA Point',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: SpinnerInput(
            middleNumberPadding: const EdgeInsets.symmetric(horizontal: 15),
            plusButton: SpinnerButtonStyle(
                width: 25,
                height: 25,
                elevation: 0,
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100)),
            minusButton: SpinnerButtonStyle(
                width: 25,
                height: 25,
                elevation: 0,
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100)),
            spinnerValue: ecapoint,
            minValue: 1,
            maxValue: 9,
            onChange: (newValue) {
              setState(() {
                ecapoint = newValue;
              });
            },
          ),
        ),
      ]),
    );
  }

  double avaibility = 1;
  Widget getAvaibility() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(children: [
        const SizedBox(height: 30),
        Text(
          'Availability',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: SpinnerInput(
            middleNumberPadding: const EdgeInsets.symmetric(horizontal: 15),
            plusButton: SpinnerButtonStyle(
                width: 25,
                height: 25,
                elevation: 0,
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100)),
            minusButton: SpinnerButtonStyle(
                elevation: 0,
                width: 25,
                height: 25,
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100)),
            spinnerValue: avaibility,
            minValue: 1,
            maxValue: 20,
            onChange: (newValue1) {
              setState(() {
                avaibility = newValue1;
              });
            },
          ),
        ),
      ]),
    );
  }
}
