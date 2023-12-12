import 'package:http/http.dart' as http;

import '../model/car.dart';

class ApiService {
  var token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTcwMjQ4MTcxNiwiYXV0aCI6IlJPTEVfQURNSU4gUk9MRV9VU0VSIiwiaWF0IjoxNzAyMzk1MzE2fQ.kYpTWxhBgFbTELHqp_WCRnlegrY27kp8uQeR-6r-ZFYTaRSeA_-7gI1L2uA7df3lDYs_RGV-QkbHemgnX-P8BQ";
  Future<List<Car>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse("https://epic-bee-happily.ngrok-free.app/api/cars");
    var response = await client.get(uri, headers: {
      "Content-Type": "application/json",
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
