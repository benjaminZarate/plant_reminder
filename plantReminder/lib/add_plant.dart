import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plantReminder/constants.dart';
import 'package:intl/intl.dart';

class AddInfoPlant extends StatefulWidget {
  @override
  _AddInfoPlantState createState() => _AddInfoPlantState();
}

class _AddInfoPlantState extends State<AddInfoPlant> {
  var date = DateTime.now();
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
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            buildPadding('Name'),
            SizedBox(height: 60),
            buildPadding('Specie'),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  buildClipOval("M"),
                  Spacer(),
                  buildClipOval("T"),
                  Spacer(),
                  buildClipOval("W"),
                  Spacer(),
                  buildClipOval("T"),
                  Spacer(),
                  buildClipOval("F"),
                  Spacer(),
                  buildClipOval("S"),
                  Spacer(),
                  buildClipOval("S"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildClipOval(String day) {
    bool pressed = false;
    return GestureDetector(
      onTap: () {},
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            color: pressed ? kButtonColor : Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                spreadRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          height: 40, // height of the button
          width: 40, // width of the button
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: pressed ? Colors.white : kButtonColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildPadding(String hint) {
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
        ),
      ),
    );
  }
}
