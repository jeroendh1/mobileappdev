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
      version: 1,
      onCreate: (Database db, int version) async {
        await onCreate(db);
      },
    );
  }

  Future<void> onCreate(Database db);

  Future<void> saveDataToDatabase(List<T> data);

  Future<List<T>> getDataFromDatabase();
}