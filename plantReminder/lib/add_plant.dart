import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantReminder/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:day_picker/day_picker.dart';

class AddInfoPlant extends StatefulWidget {
  @override
  _AddInfoPlantState createState() => _AddInfoPlantState();
}

class _AddInfoPlantState extends State<AddInfoPlant> {
  var _dateTime = DateTime.now();
  bool iconPressed = false;
  var count = 0;

  String name;
  String specie;
  List<String> days = [];
  String svgAsset;
  String hour;
  String minute;

  List<bool> _selections = List.generate(6, (index) => false);

  List<String> plantsIcons = [
    'cactus.svg',
    'barley.svg',
    'flower.svg',
    'forest.svg',
    'green.svg',
    'spring.svg'
  ];

  @override
  void initState() {
    super.initState();
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: SvgPicture.asset(
          'assets/svg/save.svg',
          width: 35,
          height: 35,
        ),
        onPressed: () {},
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
                    hour = _dateTime.hour.toString();
                    minute = _dateTime.minute.toString();
                    print(hour + ":" + minute);
                  });
                },
              ),
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
                  // <== Callback to handle the selected days
                  days = values;
                  print(days);
                },
              ),
              SizedBox(height: 20),
              buildPadding('Name', name),
              SizedBox(height: 20),
              buildPadding('Specie', specie),
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
                          svgAsset = plantsIcons[widget.key];
                          print(svgAsset);
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
    String asset = svgAsset;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        'assets/svg/$asset',
        width: 50,
        height: 50,
      ),
    );
  }

  Padding buildPadding(String hint, String stringTarget) {
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
          onSubmitted: (value) {
            stringTarget = value;
            print(stringTarget);
          },
        ),
      ),
    );
  }
}
