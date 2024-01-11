import 'package:flutter/material.dart';
import 'package:mobileappdev/viewmodel/history_viewmodel.dart';
import '../widget/menu_bar.dart';
import 'package:get/get.dart';
import '../viewmodel/main_viewmodel.dart';
// class HistoryPage extends StatelessWidget {
//   MainViewModel mainController =  Get.put(MainViewModel());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Page'),
//       ),
//       body: const Center(
//         child: Text('Search Page Content'),
//       ),
//       bottomNavigationBar: BottomNavigationBarWidget(
//         currentIndex: mainController.currentIndex.value,
//         onTap: mainController.onTabSelected,
//       ),
//     );
//   }
// }
class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryViewModel historyListController = Get.put(HistoryViewModel());
  MainViewModel mainController =  Get.put(MainViewModel());
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  TextEditingController searchController = TextEditingController();

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    await historyListController.getRentals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Reserveringen',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: refreshData,
              child: Obx(
                    () => Visibility(
                  visible:true,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: historyListController.rentals!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(6),
                          child: Stack(
                            children: [
                              Container(
                                width: 368,
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10.109890937805176),
                                    border: Border.all(color: const Color(0xffC4C4C4))
                                ),
                              ),
                              Positioned(
                                top: 20,
                                left: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${historyListController.rentals![index].car?.brand} - ${historyListController.rentals![index].car?.model} ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text('Status: ${historyListController.rentals![index].state}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text('Start datum: ${historyListController.rentals![index].toDate}' ,
                                    ),
                                    Text('Retour datum: ${historyListController.rentals![index].fromDate}' ,
                                    ),
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