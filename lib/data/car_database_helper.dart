import '../model/car.dart';
import 'base_database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CarDatabaseHelper extends BaseDatabaseHelper<Car> {
  @override
  Future<void> onCreate(Database db) async {
    await db.execute('''
      CREATE TABLE cars (
        id INTEGER PRIMARY KEY,
        brand TEXT NOT NULL,
        model TEXT NOT NULL,
        fuel TEXT CHECK(fuel IN ('GASOLINE', 'DIESEL', 'HYBRID', 'ELECTRIC')) NOT NULL,
        options TEXT,
        licensePlate TEXT,
        engineSize INTEGER NOT NULL,
        modelYear INTEGER NOT NULL,
        since TEXT NOT NULL,
        price REAL NOT NULL,
        nrOfSeats INTEGER NOT NULL,
        body TEXT CHECK(body IN ('STATIONWAGON', 'SEDAN', 'HATCHBACK', 'MINIVAN', 'MPV', 'SUV', 'COUPE', 'TRUCK', 'CONVERTIBLE')) NOT NULL
)   ''');
  }

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
