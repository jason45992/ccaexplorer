import 'package:flutter/material.dart';
import 'admin_theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:spinner_input/spinner_input.dart';

class AddDepartment extends StatefulWidget {
  const AddDepartment({Key? key}) : super(key: key);

  @override
  _AddDepartmentState createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  String? dropdownValue;
  final departmentInputController = TextEditingController();
  final positionInputController = TextEditingController();
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
            onPressed: () {},
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Select'),
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Department 1', ' Department 2', 'New Department']
              .map<DropdownMenuItem<String>>((String value) {
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
          child: TextField(
            controller: positionInputController,
            decoration: InputDecoration(
              hintText: 'Enter a new position',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
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
}
