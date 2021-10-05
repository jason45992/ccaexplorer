import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class admin_event_form extends StatelessWidget {
  const admin_event_form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Product page',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: AdminEventForm(),
    );
  }
}

class AdminEventForm extends StatefulWidget {
  @override
  _AdminEventFormState createState() => _AdminEventFormState();
}

class _AdminEventFormState extends State<AdminEventForm> {
  // ignore: non_constant_identifier_names
  final event_titile_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final event_venue_controller = TextEditingController();
  final timeinput = TextEditingController();

  // set value(String? value) {}
  // final numberController = TextEditingController();
  // String password = '';
  // bool isPasswordVisible = false;

  @override
  void initState() {
    timeinput.text = "";
    super.initState();

    event_titile_controller.addListener(() => setState(() {}));
    event_venue_controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    event_titile_controller.dispose();
    event_venue_controller.dispose();
    // numberController.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Scaffold(
          body: ListView(
            padding: EdgeInsets.all(32),
            children: [
              appBar(),
              const SizedBox(height: 20),
              EventTitle(),
              const SizedBox(height: 24),
              Organiser(),
              const SizedBox(height: 24),
              time_input(),
              const SizedBox(height: 24),
              Place(),
              const SizedBox(height: 24),

              // buildNumber(),
              // const SizedBox(height: 24),
              ButtonWidget(
                text: 'Submit',
                onClicked: () {
                  // print('Email: ${event_titile_controller.text}');
                  // print('Password: ${password}');
                  // print('Number: ${numberController.text}');
                },
              ),
            ],
          ),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget SubmitButton() {
    return Center(
      child: RaisedButton(
        child: Text(
          'Submit',
          style: TextStyle(fontSize: 18),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8),
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget EventTitle() {
    return TextField(
      controller: event_titile_controller,
      decoration: InputDecoration(
        hintText: 'Please input your event title',
        labelText: 'Event Title',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget time_input() {
    return TextField(
        controller: timeinput,
        decoration: InputDecoration(
          hintText: 'Enter Time',
          labelText: 'Time',
          border: OutlineInputBorder(),
        ),
        onTap: () async {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime(2020, 5, 5, 20, 50),
              maxTime: DateTime(2030, 6, 7, 05, 09), onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            String time = DateFormat.yMMMMEEEEd().add_jm().format(date);

            setState(() {
              timeinput.text = time; //set the value of text field.
            });
          }, locale: LocaleType.en);
        });
  }

  Widget Place() {
    return TextField(
      controller: event_venue_controller,
      decoration: InputDecoration(
        hintText: 'Please input Event Venue',
        labelText: 'Event Venue',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget appBar() {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              height: 32.0,
              width: 32.0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black87,
                  ),
                  onTap: () {},
                ),
              )),
        ],
      ),
    );
  }
}

class Organiser extends StatefulWidget {
  const Organiser({Key? key}) : super(key: key);

  @override
  State<Organiser> createState() => _OrganiserState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _OrganiserState extends State<Organiser> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Select an organiser'),
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
          items: <String>['Cultural Activity Club', 'Student Union']
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
}
