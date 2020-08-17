import 'package:flutter/material.dart';
import 'package:plantReminder/constants.dart';

class PlantCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [kSecudaryColor, Colors.green[300]],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText("Nombre: "),
              SizedBox(height: kPadding),
              buildText("Especie: "),
              SizedBox(height: kPadding),
              buildText("Dia a regar: "),
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
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Roboto',
      ),
    );
  }
}
