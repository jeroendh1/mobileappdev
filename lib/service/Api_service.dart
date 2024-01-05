import 'package:http/http.dart' as http;
import '../model/car.dart';
import '../data/SecureStorage.dart';

class ApiService {
  final SecureStorage _secureStorage = SecureStorage();
  // var token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTcwMzE1NTM4NiwiYXV0aCI6IlJPTEVfQURNSU4gUk9MRV9VU0VSIiwiaWF0IjoxNzAzMDY4OTg2fQ.fVkldDs3_JL1HjRKQjqnDpNkuHN8c7AAFGvTs8z0_Lh__FSgbP1xYi6FNc_GxffGjUPMLJxoVprkFhlZhxw61g";
  Future<List<Car>?> getCars() async {
    var client = http.Client();
    final String? token = await _secureStorage.readSecureData('token');
    if (token != null){
      var uri = Uri.parse("https://specially-equipped-swan.ngrok-free.app/api/cars");
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

}
