import 'package:flutter/material.dart';
import 'package:plantReminder/constants.dart';
import 'package:plantReminder/plant_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.3,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
        ),
        Column(
          children: [
            PlantCard(),
            PlantCard(),
            PlantCard(),
          ],
        ),
      ],
    );
  }
}
