import 'package:mobileappdev/model/customer.dart';

import '../service/Auth_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/SecureStorage.dart';
import '../model/customer.dart';

class AuthenticationViewModel {
  final SecureStorage _secureStorage = SecureStorage();

  Future<String?> login(String username, String password, bool rememberMe) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = await AuthenticationService().login(username, password, rememberMe);

    if (token != null) {
      await _secureStorage.writeSecureData('token', token);
      await _secureStorage.writeSecureData('username', username);
      await _secureStorage.writeSecureData('password', password);

      await _prefs.setBool("tokenValid", true);

      // Customer? cutomer = await AuthenticationService().getCustomer();
      // if (cutomer != null){
      //   await _prefs.setInt("customerId", cutomer.id);
      //   await _prefs.setString("firstName", cutomer.firstName);
      //   await _prefs.setString("lastName", cutomer.lastName);
      // }



      // Save current datetime in SharedPreferences
      DateTime now = DateTime.now();
      String formattedDate = now.toIso8601String();
      await _prefs.setString('tokenTimestamp', formattedDate);
      // Check if the token is older than 28 days and renew if necessary
    } else {
      // Handle authentication failure (show error message, etc.)
    }

    return token;
  }

  Future<bool> register(String username, String email, String firstname, String lastname, String password) async {
   var registered = AuthenticationService().register(username, email, firstname, lastname, password);

    return registered;
  }

  void signOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
    await _secureStorage.clear();
  }

}
