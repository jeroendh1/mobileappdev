import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/post_list_viewmodel.dart';
import '../widget/menu_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostListViewModel postListController = Get.put(PostListViewModel());
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    await postListController.getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Center(
            child: Text(
              'Auto-maat',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
        ),
        backgroundColor: Colors.black, // Set the background color to black
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refreshData,
        child: Obx(
          () => Visibility(
            visible: postListController.isLoaded.value,
            replacement:  const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              reverse: false,
              cacheExtent: 25,
              physics: const ScrollPhysics(),
              itemCount: postListController.posts!.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      Container(
                        width: 368,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.109890937805176),
                          color: Color(0xfff5f6fa),
                        ),
                      ),
                      Positioned(
                        top: 20, // Adjust the top offset as needed
                        left: 20, // Adjust the left offset as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postListController.posts![index].brand,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            )
                            ),
                            Text(
                              postListController.posts![index].model,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 20, // Adjust the bottom offset as needed
                        right: 20, // Adjust the right offset as needed
                        child: Text(
                          "€ ${postListController.posts![index].price}",
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 50,
                          child: Image(
                            image: NetworkImage(postListController.posts![index].img),
                            width: 280,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: postListController.currentIndex.value,
        onTap: postListController.onTabSelected,
      ),
    );
  }
}
