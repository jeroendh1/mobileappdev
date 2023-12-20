import 'package:flutter/material.dart';
import '../widget/menu_bar.dart';
import 'package:get/get.dart';
import '../viewmodel/main_viewmodel.dart';
class HistoryPage extends StatelessWidget {
  MainViewModel mainController =  Get.put(MainViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: const Center(
        child: Text('Search Page Content'),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: mainController.currentIndex.value,
        onTap: mainController.onTabSelected,
      ),
    );
  }
}