import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:full_screen_image/full_screen_image.dart';
import 'package:ccaexplorer/admin/admin_theme.dart';

class EventDetail extends StatefulWidget {
  const EventDetail(
      {Key? key,
      required this.eventname,
      required this.datetime,
      required this.venue,
      required this.club,
      required this.description,
      required this.eventposter})
      : super(key: key);
  final String eventname;
  final String datetime;
  final String venue;
  final String club;
  final String description;
  final String eventposter;

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              imagepad(),
              desciption_title(),
              desciption_body(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {
            showAlertDialog(context);
          },
          color: Colors.grey,
          textColor: Colors.white,
          child: Text('Register'),
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
          ElevatedButton.icon(
            onPressed: () {
              // Respond to button press
            },
            icon: Icon(
              Icons.star,
              size: 20,
              color: Colors.yellow,
            ),
            label: Text("Favourite", style: TextStyle(color: Colors.black87)),
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
    );
  }

  Widget imagepad() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        image(),
        Container(
          height: 200.0,
          width: 220,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Padding(padding: EdgeInsets.all(7), child: text()),
          ),
        )
      ]);

  Widget image() => Container(
        height: 170.0,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: FullScreenWidget(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.eventposter,
              ),
            ),
          ),
        ),
      );

  Widget text() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_available_rounded,
                color: Colors.black87,
              ),
              VerticalDivider(),
              Text(widget.eventname, style: titlestyle)
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                color: Colors.black87,
              ),
              VerticalDivider(),
              Expanded(child: Text(widget.datetime, style: titlestyle))
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_sharp,
                color: Colors.black87,
              ),
              VerticalDivider(),
              Text(widget.venue, style: titlestyle)
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.groups_rounded,
                color: Colors.black87,
              ),
              VerticalDivider(),
              Expanded(
                child: Text(widget.club, style: titlestyle),
              )
            ],
          ),
        ],
      );

  static const TextStyle titlestyle = TextStyle(
      color: Colors.black87, fontSize: 13.0, fontWeight: FontWeight.bold);

  Widget desciption_title() => Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(5),
        child: Text(
          'Description',
          style: TextStyle(
              color: Colors.black87, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );

  Widget desciption_body() => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        child: Text(
          widget.description,
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
        ),
      );
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
}
