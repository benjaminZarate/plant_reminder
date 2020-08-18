import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantReminder/constants.dart';

class PlantCard extends StatelessWidget {
  String name = " ";
  String specie = " ";
  String day = "";
  String image = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
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
                  buildText("Nombre: $name"),
                  SizedBox(height: kPadding),
                  buildText("Especie: $specie"),
                  SizedBox(height: kPadding),
                  buildText("Dia a regar: $day"),
                ],
              ),
              Spacer(),
              SvgPicture.asset(
                'assets/svg/forest.svg',
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
