import 'package:http/http.dart' as http;
import 'package:mobileappdev/model/rentals.dart';
import '../model/car.dart';
import '../data/SecureStorage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  Future<List<Rental>?> getRentals() async {
    final String? token = await _secureStorage.readSecureData('token');
    var uri = Uri.parse("$base_url/api/rentals");
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

}
