import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantReminder/Modelo/plant_info.dart';
import 'package:plantReminder/constants.dart';

// ignore: must_be_immutable
class PlantCard extends StatelessWidget {
  Plant plant;
  PlantCard(this.plant);

  String name;
  String specie;
  String day;
  int hour;
  int minute;
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [kSecondaryColor, Colors.green[300]],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
          ),
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
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText(" Name: " + plant.name),
                  SizedBox(height: kPadding),
                  buildText(" Specie: " + plant.specie),
                  SizedBox(height: kPadding),
                  buildText(plant.day.toString()),
                  SizedBox(height: kPadding),
                  buildText(" " +
                      plant.hour.toString() +
                      ":" +
                      plant.minute.toString()),
                ],
              ),
              Spacer(),
              SvgPicture.asset(
                'assets/svg/' + plant.image,
                width: 70,
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text buildText(String texto) {
    return Text(
      texto,
      style: TextStyle(
        fontFamily: 'BalooTamma2',
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
