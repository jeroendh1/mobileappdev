import 'package:mobileappdev/service/notification_service.dart';
import 'package:mobileappdev/view/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobileappdev/view/profile_page.dart';
import 'package:mobileappdev/view/register_page.dart';

import 'data/SecureStorage.dart';
import 'view/home_page.dart';
import 'view/history_page.dart';
import 'service/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final SecureStorage _secureStorage = SecureStorage(); //Voor het opstarten zonder een token
  await _secureStorage.deleteSecureData('token'); //Voor het opstarten zonder een token

  final AuthenticationService authService = AuthenticationService();

  bool tokenValid = await authService.checkAndRenewToken();
  await NotificationService().init();

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
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
      },
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/history', page: () => HistoryPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
      ],
    );
  }
}

