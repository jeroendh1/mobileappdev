import 'package:flutter/material.dart';
import '../viewmodel/car_list_viewmodel.dart';
import '../widget/menu_bar.dart';
import 'package:get/get.dart';
class HistoryPage extends StatelessWidget {
  CarListViewModel carListController = Get.put(CarListViewModel());
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
        currentIndex: carListController.currentIndex.value,
        onTap: carListController.onTabSelected,
      ),
    );
  }
}