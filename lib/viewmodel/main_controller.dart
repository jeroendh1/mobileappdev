import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;


  void onTabSelected(int index) {
    currentIndex.value = index;

    // Navigate to the corresponding page
    switch (index) {
      case 0:
      // Get.toNamed('/') For arrow above page
        Get.toNamed('/home');
        break;
      case 1:
        Get.toNamed('/history');
        break;
      case 2:
        Get.toNamed('/profile');
      // Profile page
        break;
    }
  }

}
