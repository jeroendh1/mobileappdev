import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileappdev/viewmodel/history_viewmodel.dart';
import '../widget/menu_bar.dart';
import '../viewmodel/main_viewmodel.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryViewModel historyListController = Get.put(HistoryViewModel());
  MainViewModel mainController = Get.put(MainViewModel());
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  TextEditingController searchController = TextEditingController();

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    await historyListController.getRentals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Reserveringen', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: refreshData,
              child: Obx(
                    () => Visibility(
                  visible: true,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: historyListController.rentals!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 2), // changes the position of the shadow
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              child: Image(
                                image: AssetImage(historyListController.rentals![index].car!.img),

                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${historyListController.rentals![index].car?.brand} - ${historyListController.rentals![index].car?.model} ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Status: ${historyListController.rentals![index].state}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffF9B401),
                                    ),
                                  ),
                                  Text('Start datum: ${historyListController.rentals![index].fromDate}'),
                                  Text('Retour datum: ${historyListController.rentals![index].toDate}'),
                                  // Add more details here (pickup location, prices, etc.)
                                ],
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: mainController.currentIndex.value,
        onTap: mainController.onTabSelected,
      ),
    );
  }
}
