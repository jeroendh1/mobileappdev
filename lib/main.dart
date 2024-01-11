import 'package:mobileappdev/view/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'data/SecureStorage.dart';
import 'view/home_page.dart';
import 'view/history_page.dart';
import 'service/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final SecureStorage _secureStorage = SecureStorage();
  await _secureStorage.deleteSecureData('token');

  final AuthenticationService authService = AuthenticationService();

  bool tokenValid = await authService.checkAndRenewToken();


  runApp(MyApp(tokenValid: tokenValid));
}

class MyApp extends StatelessWidget {
  final bool tokenValid;

  MyApp({required this.tokenValid});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      home: tokenValid ? HomePage() : LoginPage(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/search', page: () => HistoryPage()),
      ],
    );
  }
}

