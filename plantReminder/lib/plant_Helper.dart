import 'package:plantReminder/Modelo/plant_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = "Plant";
final String columnID = 'id';
final String columnName = 'name';
final String columnSpecie = 'specie';
final String columnImage = 'image';
final String columnDay = 'day';
final String columnHour = 'hour';
final String columnMinute = 'minute';

class PlantHelper {
  static Database _database;
  static PlantHelper _plantHelper;

  int listLenght = 0;
  PlantHelper._createInstance();
  factory PlantHelper() {
    if (_plantHelper == null) {
      _plantHelper = PlantHelper._createInstance();
    }
    return _plantHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "plant.db";

    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
      create table $tableName(
        $columnID integer primary key autoincrement,
        $columnName text,
        $columnSpecie text,
        $columnImage text,
        $columnDay text not null,
        $columnHour integer not null,
        $columnMinute integer not null
      )
          ''');
    });
    return database;
  }

  void insertPlant(Plant plant) async {
    var db = await this.database;
    var result = await db.insert(tableName, plant.toJson());
    print('result: $result');
  }

  Future<List<Plant>> getPlants() async {
    List<Plant> _plants = [];
    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var plantInfo = Plant.fromJson(element);
      _plants.add(plantInfo);
    });
    listLenght = _plants.length;
    return _plants;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableName, where: '$columnID = ?', whereArgs: [id]);
  }
}
