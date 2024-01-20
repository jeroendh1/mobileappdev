import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class BaseDatabaseHelper<T> {
  static Database? _database;
  static const String dbName = 'autoMaat.db';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 3,
      onCreate: (Database db, int version) async {
        await createCarTable(db);
        await createRentalTable(db);
      },
    );
  }

  Future<void> createCarTable(Database db) async {
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

  Future<void> createRentalTable(Database db) async {
    await db.execute('''
      CREATE TABLE rentals (
        id INTEGER PRIMARY KEY,
        code TEXT NOT NULL,
        longitude REAL NOT NULL,
        latitude REAL NOT NULL,
        fromDate TEXT NOT NULL,
        toDate TEXT NOT NULL,
        state TEXT CHECK(state IN ('ACTIVE', 'RESERVED', 'PICKUP', 'RETURNED')) NOT NULL,
        car_id INTEGER NOT NULL, 
        FOREIGN KEY (car_id) REFERENCES cars(id)
      )
    ''');
  }

  Future<void> saveDataToDatabase(List<T> data);

  Future<List<T>> getDataFromDatabase();
}