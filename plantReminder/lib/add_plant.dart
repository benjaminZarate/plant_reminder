import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantReminder/Modelo/plant_info.dart';
import 'package:plantReminder/constants.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:day_picker/day_picker.dart';
import 'package:plantReminder/main.dart';
import 'package:plantReminder/plant_Helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class AddInfoPlant extends StatefulWidget {
  @override
  _AddInfoPlantState createState() => _AddInfoPlantState();
}

class _AddInfoPlantState extends State<AddInfoPlant> {
  var _dateTime = DateTime.now();

  List<bool> _selections = List.generate(6, (index) => false);

  List<int> days = new List<int>();
  Time timeSchedule;

  String name = "";
  String specie = "";
  String image = "cactus.svg";
  String day = "";
  int hour = 00;
  int minute = 00;

  List<String> plantsIcons = [
    'cactus.svg',
    'barley.svg',
    'flower.svg',
    'forest.svg',
    'green.svg',
    'spring.svg'
  ];

  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlSpecie = TextEditingController();

  PlantHelper _plantHelper = PlantHelper();

  @override
  void initState() {
    super.initState();
    _plantHelper.initializeDatabase().then((value) {
      print("initialized");
    });
    ctrlName.text = name;
    ctrlSpecie.text = specie;
  }

  //Notification call
  void scheduleNotfication(int day) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      "Channel for Alarm notification",
      icon: 'icon',
      largeIcon: DrawableResourceAndroidBitmap('icon'),
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        "$name - $specie",
        "Remember to water me!",
        Day(day),
        timeSchedule,
        platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Add a plant",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //Save Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: SvgPicture.asset(
          'assets/svg/save.svg',
          width: 35,
          height: 35,
        ),
        onPressed: () {
          //create a new Plant object to add it to the database and
          //go through a list of integers to assign which day have to send a notification
          try {
            Plant newPlant = new Plant(
                name: name,
                specie: specie,
                image: image,
                day: day,
                hour: hour,
                minute: minute);
            _plantHelper.insertPlant(newPlant);
            Navigator.pop(context);
          } catch (e) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("There is missing information")));
          }
          for (int value in days) {
            scheduleNotfication(value);
          }
        },
      ),
      body: Container(
        padding: EdgeInsets.all(kPadding),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          image: DecorationImage(
            image: AssetImage('assets/images/leafbackground.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Select the time when is going to ring the notification
              TimePickerSpinner(
                is24HourMode: false,
                normalTextStyle: TextStyle(fontSize: 24, color: Colors.white),
                highlightedTextStyle:
                    TextStyle(fontSize: 24, color: Colors.yellow),
                spacing: 35,
                itemHeight: 50,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    _dateTime = time;
                    hour = _dateTime.hour;
                    minute = _dateTime.minute;
                    timeSchedule = Time(hour, minute, 0);
                  });
                },
              ),
              //Select the day when is going to ring the notification
              SelectWeekDays(
                border: false,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: new LinearGradient(
                    colors: [kSecondaryColor, Colors.green[300]],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                  ),
                ),
                onSelect: (values) {
                  //print(values);
                  day = '';
                  days.clear();
                  for (var dayString in values) {
                    String newDate = dayString;
                    day = day + ' ' + newDate.substring(0, 3);
                    switch (dayString) {
                      case "Sunday":
                        days.add(1);
                        break;
                      case "Monday":
                        days.add(2);
                        break;
                      case "Tuesday":
                        days.add(3);
                        break;
                      case "Wednesday":
                        days.add(4);
                        break;
                      case "Thursday":
                        days.add(5);
                        break;
                      case "Friday":
                        days.add(6);
                        break;
                      case "Saturday":
                        days.add(7);
                        break;
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green[900],
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                    controller: ctrlName,
                    onChanged: (value) => name = value,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green[900],
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Specie",
                    ),
                    controller: ctrlSpecie,
                    onChanged: (value) => specie = value,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: kPadding, left: kPadding),
                child: Text(
                  "Select an icon: ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  children: [
                    plantIconButton('cactus.svg'),
                    plantIconButton('barley.svg'),
                    plantIconButton('flower.svg'),
                    plantIconButton('forest.svg'),
                    plantIconButton('green.svg'),
                    plantIconButton('spring.svg')
                  ].asMap().entries.map((widget) {
                    return ToggleButtons(
                      renderBorder: false,
                      fillColor: Colors.lightGreen,
                      isSelected: [_selections[widget.key]],
                      onPressed: (_) {
                        setState(() {
                          for (int i = 0; i < _selections.length; i++) {
                            if (_selections[i] != _selections[widget.key]) {
                              if (_selections[i]) {
                                _selections[i] = false;
                              }
                            }
                          }
                          _selections[widget.key] = !_selections[widget.key];
                          _selections[widget.key]
                              ? image = plantsIcons[widget.key].toString()
                              : image = plantsIcons[0].toString();
                        });
                      },
                      children: [widget.value],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Padding plantIconButton(String svgAsset) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        'assets/svg/$svgAsset',
        width: 50,
        height: 50,
      ),
    );
  }

  Padding textField(
      String hint, String stringTarget, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.green[900],
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
          ),
          controller: controller,
          onChanged: (value) => stringTarget = value,
        ),
      ),
    );
  }
}
