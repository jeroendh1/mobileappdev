import 'package:get/get.dart';

class HistoryViewModel extends GetxController {
  RxInt currentIndex = 1.obs;

  void onTabSelected(int index) {
    currentIndex.value = index;

    // Navigate to the corresponding page
    switch (index) {
      case 0:
        Get.toNamed('/');
        break;
      case 1:
        Get.toNamed('/search'); // Navigate to the search page
        break;
      case 2:
      // Profile page
        break;
    }
  }

}
