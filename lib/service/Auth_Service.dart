import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/SecureStorage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/customer.dart';


final String? base_url = dotenv.env['Base_URL'];

class AuthenticationService {
  final SecureStorage _secureStorage = SecureStorage();

  Future<String?> logintest(String username, String password, bool rememberMe) async {
    try {
      var uri = Uri.parse('$base_url/api/authenticate');
      var response = await http.post(
        uri,
        body: jsonEncode({
          'username': username,
          'password': password,
          'rememberMe': rememberMe,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Extract and return the JWT token from the response
        var token = response.headers['authorization'];
        print(token);
        return token;
      } else {
        // Handle different status codes or error scenarios
        return null;
      }
    } catch (e) {
      // Handle exceptions or network errors
      print('Error refreshing token: $e');
      return null;
    }
  }

  Future<String> login(String username, String password, bool rememberMe) async {
    var uri = Uri.parse('$base_url/api/authenticate');
    var response = await http.post(
      uri,
      body: jsonEncode({
        'username': username,
        'password': password,
        'rememberMe': rememberMe,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200){
      throw Exception('Failed to authenticate: ${response.statusCode}');
    } else {
      return response.headers['authorization']!;
    }
  }

  Future<String?> refreshToken() async {
    try {
      var uri = Uri.parse('$base_url/api/authenticate');
      final String? username = await _secureStorage.readSecureData('username');
      final String? password = await _secureStorage.readSecureData('password');
      var response = await http.post(
        uri,
        body: jsonEncode({
          'username': username,
          'password': password,
          'rememberMe': true,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Extract and return the refreshed JWT token from the response
        var refreshedToken = response.headers['authorization'];
        return refreshedToken;
      } else {
        // Handle different status codes or error scenarios
        return null;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }

  Future<bool> checkAndRenewToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final String? token = await _secureStorage.readSecureData('token');
    if (token != "No data found!") {
      String? storedTimestamp = _prefs.getString('tokenTimestamp');
      if (storedTimestamp != null) {
        DateTime tokenDate = DateTime.parse(storedTimestamp);
        DateTime now = DateTime.now();
        Duration difference = now.difference(tokenDate);

        if (difference.inDays >= 28) {
          // Token is older than 28 days, renew the token here
          String? refreshedToken = await refreshToken();
          if (refreshedToken != null) {
            await _secureStorage.writeSecureData('token', refreshedToken);
            // Update timestamp in SharedPreferences
            String updatedTimestamp = DateTime.now().toIso8601String();
            await _prefs.setString('tokenTimestamp', updatedTimestamp);
            return true; // Token was renewed
          }
        } else {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> register(String username, String email, String firstname, String lastname, String password) async {
    try {
      var uri = Uri.parse('$base_url/api/AM/register');
      var response = await http.post(
        uri,
        body: jsonEncode({
          'login': username,
          'email': email,
          "firstName": firstname,
          "lastName": lastname,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Extract and return the JWT token from the response
        return true;
      } else {
        // Handle different status codes or error scenarios
        return false;
      }
    } catch (e) {
      // Handle exceptions or network errors
      print('Error bij registratie: $e');
      return false;
    }
  }

  Future<Customer?> getCustomer() async {
    final String? token = await _secureStorage.readSecureData('token');
    if (token != null){
      var uri = Uri.parse("$base_url/api/AM/me");
      var response = await http.Client().get(uri, headers: {
        'Authorization': token,
      });

      if (response.statusCode == 200) {
        return Customer.fromJson(json.decode(response.body));
      } else {
        throw Exception("Unable to perform request!");
      }
    } else {
      return null;
    }
  }

}
