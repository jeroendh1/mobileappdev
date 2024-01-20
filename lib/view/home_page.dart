import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileappdev/view/product_details_page.dart';
import '../viewmodel/home_viewmodel.dart';
import '../viewmodel/main_controller.dart';
import '../widget/menu_bar.dart';

import '../widget/filter_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel carListController = Get.put(HomeViewModel());
  MainController mainController =  Get.put(MainController());
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  TextEditingController searchController = TextEditingController();

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    await carListController.getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Auto-maat',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(40.0),
            color: Colors.black,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Zoeken...',
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.settings, color:  Color(0xffF9B401)),
                  onPressed: () {
                    _showFilterBottomSheet(context);
                  },
                ),
              ),
              onChanged: (value) {
                String query = searchController.text.toLowerCase();
                  carListController.searchFilter(query);
              },
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: refreshData,
              child: Obx(
                    () => Visibility(
                  visible: carListController.isLoaded.value,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: carListController.posts!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the product details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  car: carListController.posts![index],
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 368,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10.109890937805176),
                                  color: Color(0xfff5f6fa),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                left: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(carListController.posts![index].brand,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text(
                                      carListController.posts![index].model,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 20,
                                child: Text(
                                  "€ ${carListController.posts![index].price}",
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 25.0),
                                    child: Image(
                                      image: AssetImage(carListController.posts![index].img),
                                      width: 280,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: mainController.currentIndex.value,
        onTap: mainController.onTabSelected,
      ),
    );
  }
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return FilterModalBottomSheet();
      },
    );
  }
}
