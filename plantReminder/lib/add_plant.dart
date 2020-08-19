import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantReminder/constants.dart';
import 'package:intl/intl.dart';

class AddInfoPlant extends StatefulWidget {
  @override
  _AddInfoPlantState createState() => _AddInfoPlantState();
}

class _AddInfoPlantState extends State<AddInfoPlant> {
  var date = DateTime.now();
  bool iconPressed = false;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildPadding('Name'),
            SizedBox(height: 40),
            buildPadding('Specie'),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dayButton("M"),
                Spacer(),
                dayButton("T"),
                Spacer(),
                dayButton("W"),
                Spacer(),
                dayButton("T"),
                Spacer(),
                dayButton("F"),
                Spacer(),
                dayButton("S"),
                Spacer(),
                dayButton("S"),
              ],
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
            GridView.count(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                plantIconButton('cactus.svg'),
                plantIconButton('barley.svg'),
                plantIconButton('flower.svg'),
                plantIconButton('forest.svg'),
                plantIconButton('green.svg'),
                plantIconButton('spring.svg')
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                  child: Icon(
                    Icons.save,
                    size: 40,
                  ),
                  onPressed: () {},
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding plantIconButton(String svgAsset) {
    bool pressed = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        onPressed: () {
          setState(() {
            iconPressed = true;
            pressed = !pressed;
          });
        },
        child: SvgPicture.asset(
          'assets/svg/$svgAsset',
          width: 50,
          height: 50,
        ),
        shape: new CircleBorder(),
        elevation: 10.0,
        fillColor: pressed ? kSecondaryColor : Colors.white,
        constraints: BoxConstraints(
            minHeight: 35, maxHeight: 40, minWidth: 35, maxWidth: 40),
      ),
    );
  }

  RawMaterialButton dayButton(String day) {
    bool pressed = false;
    return RawMaterialButton(
      onPressed: () {
        pressed = !pressed;
        print(pressed);
        print(day);
      },
      child: Text(
        day,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      shape: new CircleBorder(),
      elevation: 10.0,
      fillColor: pressed ? kSecondaryColor : Colors.white,
      constraints: BoxConstraints(
          minHeight: 40, maxHeight: 45, minWidth: 40, maxWidth: 45),
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
