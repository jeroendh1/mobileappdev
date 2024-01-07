import '../model/car.dart';
import 'base_database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CarDatabaseHelper extends BaseDatabaseHelper<Car> {

  @override
  Future<void> saveDataToDatabase(List<Car> data) async {
    Database db = await database;

    // Clear existing data
    await db.delete('cars');

    // Insert new data
    for (Car car in data) {
      await db.insert('cars', car.toJson());
    }
  }

  @override
  Future<List<Car>> getDataFromDatabase() async {
    Database db = await database;
    List<Map<String, dynamic>> storedCars = await db.query('cars');
    return storedCars.map((car) => Car.fromJson(car)).toList();
  }
}
