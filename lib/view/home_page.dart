import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/post_list_viewmodel.dart';
import '../widget/shimmer_list.dart';

class HomePage extends StatelessWidget {
  final PostListViewModel postListController = Get.put(PostListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Data From API')),
      ),
      body: SafeArea(
        child: Obx(
          () => Visibility(
            visible: postListController.isLoaded.value,
            replacement:  Center(
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
    );
  }
}
