import 'package:flutter/material.dart';
import 'admin_theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:spinner_input/spinner_input.dart';

class DepartmentPosition extends StatefulWidget {
  const DepartmentPosition({Key? key}) : super(key: key);

  @override
  _DepartmentPositionState createState() => _DepartmentPositionState();
}

class _DepartmentPositionState extends State<DepartmentPosition> {
  final departmentnameInputController = TextEditingController();
  final positionInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              getAppBarUI(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  children: [
                    getDepartmentName(),
                    positionModify(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {},
            color: Colors.grey,
            textColor: Colors.white,
            child: Text('Update'),
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
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
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
          child: TextField(
            controller: departmentnameInputController,
            decoration: InputDecoration(
              labelText: 'Department 1',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        )
      ],
    );
  }

  Widget positionModify() {
    return Column(
      children: [
        getposition(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getEcaPoint(),
            getAvaibility(),
          ],
        ),
      ],
    );
  }

  Widget getposition() {
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
                  'Position 1 Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
            )
          ],
        ),
        Container(
          child: TextField(
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
