import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobileappdev/model/rentals.dart';
import '../model/car.dart';

class ApiService {
  var token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTcwNTA4NDIzMywiYXV0aCI6IlJPTEVfQURNSU4gUk9MRV9VU0VSIiwiaWF0IjoxNzAyNDkyMjMzfQ.KFI5Cpn5NfxUU0lAPVjWgw8W73EdczXEJGxG3tnYUzUMOFdVJbKoL-ylADfUlm7fFijUno-ARakxXjS_P_iFEA";
  Future<List<Car>?> getCars() async {
    var client = http.Client();
    var uri = Uri.parse("https://epic-bee-happily.ngrok-free.app/api/cars");
    var response = await http.Client().get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return carFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<List<Rental>?> getRentals() async {
    var client = http.Client();
    var uri = Uri.parse("https://epic-bee-happily.ngrok-free.app/api/rentals");
    var response = await http.Client().get(uri, headers: {
      'Authorization': 'Bearer $token',
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
      var uri = Uri.parse("https://epic-bee-happily.ngrok-free.app/api/rentals");
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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
