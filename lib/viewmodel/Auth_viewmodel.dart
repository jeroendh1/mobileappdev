import '../service/Auth_Service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/SecureStorage.dart';

class AuthenticationViewModel {
  // final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final SecureStorage _secureStorage = SecureStorage();

  // AuthStatus _authStatus = AuthStatus.unauthenticated;
  // AuthStatus get authStatus => _authStatus;

  Future<String?> login(String username, String password, bool rememberMe) async {
    // _authStatus = AuthStatus.authenticating;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = await AuthenticationService().login(username, password, rememberMe);

    if (token != null) {
      // _authStatus = AuthStatus.authenticated;
      await _secureStorage.writeSecureData('token', token);

      // Save current datetime in SharedPreferences
      DateTime now = DateTime.now();
      String formattedDate = now.toIso8601String();
      await _prefs.setString('tokenTimestamp', formattedDate);
      // Check if the token is older than 28 days and renew if necessary
    } else {
      // _authStatus = AuthStatus.unauthenticated;
      // Handle authentication failure (show error message, etc.)
    }

    return token;
  }

}
