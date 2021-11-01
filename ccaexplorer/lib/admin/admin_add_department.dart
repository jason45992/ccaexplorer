import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'admin_theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:spinner_input/spinner_input.dart';

class AddDepartment extends StatefulWidget {
  const AddDepartment({Key? key, required this.clubid}) : super(key: key);
  final String clubid;

  @override
  _AddDepartmentState createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  String? dropdownValue;
  final departmentInputController = TextEditingController();
  final positionInputController = TextEditingController();
  List<String> departmentList = [];
  List<DepartmentList> rdepartmentList = [];
  String department_id = '';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> addEvent() async {
    await Firebase.initializeApp();
    final clubRole = FirebaseFirestore.instance.collection('club_role').doc();
    final clubDepartment =
        FirebaseFirestore.instance.collection('club_department').doc();
    final refid = clubRole.id;
    final clubdefid = clubDepartment.id;
    if (dropdownValue == 'New Department') {
      clubDepartment
          .set({
            'club_id': widget.clubid,
            'department_id': clubdefid,
            'name': departmentInputController.text,
          })
          .then((value) => print("Club Department Added"))
          .catchError((error) => print("Failed to add user: $error"));
      clubRole
          .set({
            'Availability': avaibility,
            'ECA_point': ecapoint,
            'department_id': clubdefid,
            'id': refid,
            'is_admin': false,
            'position': positionInputController.text,
          })
          .then((value) => print("Club Role Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } else {
      clubRole
          .set({
            'Availability': avaibility,
            'ECA_point': ecapoint,
            'department_id': department_id,
            'id': refid,
            'is_admin': false,
            'position': positionInputController.text,
          })
          .then((value) => print("Club Role Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            getAppBarUI(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                children: <Widget>[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5),
                    child: Text(
                      'Department',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  addDepartment(),
                  ..._getNewDepartment(),
                  getposition(),
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
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              if (_formkey.currentState!.validate() &&
                  _formkey2.currentState!.validate()) {
                print("successful");
                addEvent();
                showAlertDialog(context);
                return;
              } else {
                print("UnSuccessfull");
              }
            },
            color: Colors.grey,
            textColor: Colors.white,
            child: Text('Add'),
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
          mainAxisAlignment: MainAxisAlignment.start,
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
            const SizedBox(width: 70),
            Text(
              'Add',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget addDepartment() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Form(
        key: _formkey,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          validator: (value) => value == null ? 'field required' : null,
          hint: Text('Select'),
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              rdepartmentList.forEach((element) {
                if (element.department_name == newValue) {
                  setState(() {
                    department_id = element.department_id;
                  });
                }
              });
            });
          },
          items: departmentList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Widget> _getNewDepartment() {
    List<Widget> friendsTextFields = [];
    if (dropdownValue == 'New Department') {
      friendsTextFields.add(Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
              child: Text(
                'New Department',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          departmentInput(),
        ],
      ));
    }
    return friendsTextFields;
  }

  Widget getposition() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: Text(
              'Position',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Container(
          child: Form(
            key: _formkey2,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Position';
                }
                return null;
              },
              controller: positionInputController,
              decoration: InputDecoration(
                hintText: 'Enter a new position',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
        )
      ],
    );
  }

  Widget departmentInput() {
    return Container(
      child: TextField(
        controller: departmentInputController,
        decoration: InputDecoration(
          hintText: 'Enter a new department',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
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
            onChange: (newValue) {
              setState(() {
                avaibility = newValue;
              });
            },
          ),
        ),
      ]),
    );
  }

  Future<void> getdata() async {
    //get the department collectionn
    CollectionReference _departmentCollectionRef =
        FirebaseFirestore.instance.collection('club_department');
    QuerySnapshot departmentListQuerySnapshot = await _departmentCollectionRef
        .where('club_id', isEqualTo: widget.clubid)
        .get();

    departmentListQuerySnapshot.docs.forEach((element) {
      departmentList.add(element.get('name'));
      rdepartmentList.add(DepartmentList(
          department_id: element.get('department_id'),
          department_name: element.get('name')));
    });
    departmentList.add('New Department');

    setState(() {});
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
      backgroundColor: Colors.white,
      elevation: 2,
      buttonPadding: EdgeInsets.symmetric(vertical: 20),
      content: Text(
        "Added successfully.",
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
}

class DepartmentList {
  DepartmentList({
    required this.department_id,
    required this.department_name,
  });
  final String department_id;
  final String department_name;
}
