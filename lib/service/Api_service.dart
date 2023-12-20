import 'package:http/http.dart' as http;
import '../model/car.dart';

class ApiService {
  var token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTcwNTA4NDIzMywiYXV0aCI6IlJPTEVfQURNSU4gUk9MRV9VU0VSIiwiaWF0IjoxNzAyNDkyMjMzfQ.KFI5Cpn5NfxUU0lAPVjWgw8W73EdczXEJGxG3tnYUzUMOFdVJbKoL-ylADfUlm7fFijUno-ARakxXjS_P_iFEA";
  Future<List<Car>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse("https://epic-bee-happily.ngrok-free.app/api/cars");

    var response = await client.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var json = response.body;
      print(json.toString());
      return carFromJson(json);
    } else {
      print(response.statusCode);
      throw Exception("Unable to perform request!");
    }
  }
}
