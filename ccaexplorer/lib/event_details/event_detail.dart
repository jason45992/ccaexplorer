import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

class EventDetail extends StatelessWidget {
  const EventDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Product page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Product page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              appBar(),
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
          onPressed: () {},
          color: Colors.red,
          textColor: Colors.white,
          child: Text('Register'),
        ),
      ),
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
          color: Colors.transparent, borderRadius: BorderRadius.circular(4.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: FullScreenWidget(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/mechchallenge.jpeg",
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
            Text('Mech Challenge', style: titlestyle)
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.access_time_outlined,
              color: Colors.black87,
            ),
            VerticalDivider(),
            Expanded(
                child:
                    Text('4 March 2021 (Thu) 1.30pm-5.30pm', style: titlestyle))
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.location_on_sharp,
              color: Colors.black87,
            ),
            VerticalDivider(),
            Text('The Arc', style: titlestyle)
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
              child: Text('American Society of Mechanical Engineering',
                  style: titlestyle),
            )
          ],
        ),
      ],
    );

const TextStyle titlestyle = TextStyle(
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
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc',
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
      ),
    );
