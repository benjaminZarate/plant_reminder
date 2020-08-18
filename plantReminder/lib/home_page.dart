import 'package:flutter/material.dart';
import 'package:plantReminder/body.dart';
import 'package:plantReminder/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[500],
        child: Icon(Icons.add, size: 35),
        onPressed: () {
          Navigator.pushNamed(context, '/addPlant');
        },
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      onPressed: () {},
    ),
  );
}
