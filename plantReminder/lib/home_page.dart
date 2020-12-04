import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plantReminder/Modelo/plant_info.dart';
import 'package:plantReminder/add_plant.dart';
import 'package:plantReminder/constants.dart';
import 'package:plantReminder/main.dart';
import 'package:plantReminder/plant_Helper.dart';
import 'package:plantReminder/plant_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Plant>> _plants;
  PlantHelper _plantHelper = PlantHelper();

  @override
  void initState() {
    _plantHelper.initializeDatabase().then((value) {
      loadPlants();
    });
    super.initState();
  }

  void loadPlants() {
    _plants = _plantHelper.getPlants();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[200],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[500],
          child: Icon(Icons.add, size: 35),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddInfoPlant()))
                .then((value) {
              setState(() {
                loadPlants();
              });
            });
          },
        ),
        body: FutureBuilder(
          future: _plants,
          builder: (context, snapshot) {
            if (_plantHelper.listLenght > 0) {
              return ListView(
                children: snapshot.data.map<Widget>((e) {
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      _plantHelper.delete(e.id);
                      loadPlants();
                    },
                    child: PlantCard(e),
                  );
                }).toList(),
              );
            }
            return Center(
              child: Text(
                "You have no plants :(",
                style: TextStyle(
                  fontFamily: 'BalooTamma2',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                  fontSize: 30,
                ),
              ),
            );
          },
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
