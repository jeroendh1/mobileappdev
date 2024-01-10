import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/SecureStorage.dart';

class AuthenticationService {
  final SecureStorage _secureStorage = SecureStorage();

  Future<String?> login(String username, String password, bool rememberMe) async {
    try {
      var uri = Uri.parse('https://specially-equipped-swan.ngrok-free.app/api/authenticate');
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

  Future<String?> refreshToken() async {
    try {
      var uri = Uri.parse('https://specially-equipped-swan.ngrok-free.app/api/authenticate');
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
}
