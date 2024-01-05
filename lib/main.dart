import 'package:mobileappdev/view/login_page.dart';

import 'view/home_page.dart';
import 'view/history_page.dart';
import 'service/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/search', page: () => HistoryPage()),
      ],
    );
  }
}

