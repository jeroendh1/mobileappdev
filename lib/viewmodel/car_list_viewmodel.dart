import 'package:get/get.dart';

import '../service/Api_service.dart';
import 'car_viewmodel.dart';

class CarListViewModel extends GetxController {
  List<CarViewModel>? posts = RxList<CarViewModel>();
  var isLoaded = false.obs;

  getData() async {
    final result = await ApiService().getPosts();
    if (result != null) {
      posts?.clear();
      posts?.addAll(result.map((p) => CarViewModel(car: p)).toList());
      // posts = result.map((p) => CarViewModel(car: p)).toList();
      print("getdata");
      isLoaded.value = true;
    }
  }
  RxInt currentIndex = 0.obs;

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
  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
