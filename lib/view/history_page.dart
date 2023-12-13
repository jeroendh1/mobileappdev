import 'package:flutter/material.dart';
import '../viewmodel/post_list_viewmodel.dart';
import '../widget/menu_bar.dart';
import 'package:get/get.dart';
class HistoryPage extends StatelessWidget {
  PostListViewModel postListController = Get.put(PostListViewModel());
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
        currentIndex: postListController.currentIndex.value,
        onTap: postListController.onTabSelected,
      ),
    );
  }
}