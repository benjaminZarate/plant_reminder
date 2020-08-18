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
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            PlantCard(),
          ],
        ),
      ),
    );
  }
}
