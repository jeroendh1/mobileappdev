import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobileappdev/model/rentals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/car.dart';
import '../data/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/inspection.dart';

final String? base_url = dotenv.env['Base_URL'];

class ApiService {
  final SecureStorage _secureStorage = SecureStorage();
  Future<List<Car>?> getCars() async {
    final String? token = await _secureStorage.readSecureData('token');
    if (token != null){
      var uri = Uri.parse("$base_url/api/cars");
      var response = await http.Client().get(uri, headers: {
        'Authorization': token,
      });

      if (response.statusCode == 200) {
        return carFromJson(response.body);
      } else {
        throw Exception("Unable to perform request!");
      }
    } else {
      return null;
    }
  }

  Future<void> postImage(image, rentalId) async {
    try {
      final String? token = await _secureStorage.readSecureData('token');
      var uri = Uri.parse("$base_url/api/inspections");
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token!,
        },
        body: jsonEncode({
          'photo': image,
          'photoContentType': "string",
          "rental": {"id":rentalId}
        }),
      );

      if (response.statusCode == 201) {
        print('Rental created successfully');
      } else {
        throw Exception("Unable to create rental!");
      }
    } catch (e) {
      print('Error creating rental: $e');
    }
  }

  Future<List<Rental>?> getRentals() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final String? token = await _secureStorage.readSecureData('token');
    int? cutomerId = _prefs.getInt('customerId');
    var uri = Uri.parse("$base_url/api/rentals?customerId.equals=$cutomerId");
    var response = await http.Client().get(uri, headers: {
      'Authorization': token!,
    });

    if (response.statusCode == 200) {
      print(response.body);
      return rentalFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
  Future<void> createRental(Rental newRental) async {
    try {
      final String? token = await _secureStorage.readSecureData('token');
      var uri = Uri.parse("$base_url/api/rentals");
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token!,
        },
        body:json.encode(newRental.toJsonWithCar()),
      );

      if (response.statusCode == 201) {
        print('Rental created successfully');
      } else {
        throw Exception("Unable to create rental!");
      }
    } catch (e) {
      print('Error creating rental: $e');
    }
  }
}
