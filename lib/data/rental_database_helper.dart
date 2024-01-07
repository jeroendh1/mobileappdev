import '../model/rentals.dart';

import 'base_database_helper.dart';
import 'package:sqflite/sqflite.dart';

class RentalDatabaseHelper extends BaseDatabaseHelper<Rental> {

  @override
  Future<void> saveDataToDatabase(List<Rental> data) async {
    Database db = await database;

    // Clear existing data
    await db.delete('rentals');

    // Insert new data
    for (Rental rental in data) {
      await db.insert('rentals', rental.toJson());
    }
  }

  @override
  Future<List<Rental>> getDataFromDatabase() async {
    Database db = await database;
    List<Map<String, dynamic>> storedRentals = await db.query('rentals');
    return storedRentals.map((rental) => Rental.fromJson(rental)).toList();
  }

}
