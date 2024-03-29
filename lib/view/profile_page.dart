import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';
import '../controllers/main_controller.dart';
import '../widget/menu_bar.dart';
import 'damage_report_page.dart';
import 'faq_page.dart';

class ProfilePage extends StatelessWidget {
  AuthenticationViewModel authController = Get.put(AuthenticationViewModel());
  MainController mainController =  Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Profiel', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffF9B401),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Username',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor:  Color(0xffF9B401), // Text color
                ),
                child: Text('FAQ'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DamageReportPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor:  Color(0xffF9B401), // Text color
                ),
                child: Text('Schade Melden'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Sign Out Logic
                  authController.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                ),
                child: Text('Sign Out'),
              ),

            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentIndex: mainController.currentIndex.value,
          onTap: mainController.onTabSelected,
        ),
      ),
    );
  }
}
