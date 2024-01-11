import 'package:get/get.dart';

class MainViewModel extends GetxController {
  RxInt currentIndex = 0.obs;




  void onTabSelected(int index) {
    currentIndex.value = index;

    // Navigate to the corresponding page
    switch (index) {
      case 0:
      // Get.toNamed('/') For arrow above page
        Get.offAllNamed('/home');
        break;
      case 1:
        Get.offAllNamed('/search'); // Navigate to the search page
        break;
      case 2:
      // Profile page
        break;
    }
  }

}
