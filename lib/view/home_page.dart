import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileappdev/view/product_details_page.dart';
import '../viewmodel/car_list_viewmodel.dart';
import '../widget/menu_bar.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarListViewModel carListController = Get.put(CarListViewModel());
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  TextEditingController searchController = TextEditingController();

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    await carListController.getData();
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
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.settings, color:  Color(0xffF9B401)),  // Your extra option button icon
                  onPressed: () {
                    // Handle the action when the extra option button is pressed
                    // this is needed to build filter
                    print('Extra option button pressed');
                  },
                ),
              ),
              onChanged: (value) {
                // Handle search logic here
                // Here needs to be te logic to filter based on search
                print(value);
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
                    reverse: false,
                    cacheExtent: 25,
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
                                top: 20, // Adjust the top offset as needed
                                left: 20, // Adjust the left offset as needed
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
                                top: 20, // Adjust the bottom offset as needed
                                right: 20, // Adjust the right offset as needed
                                child: Text(
                                  "€ ${carListController.posts![index].price}",
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: Image(
                                    image: NetworkImage(carListController.posts![index].img),
                                    width: 280,
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
        currentIndex: carListController.currentIndex.value,
        onTap: carListController.onTabSelected,
      ),
    );
  }
}
