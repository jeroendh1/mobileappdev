import 'package:get/get.dart';

import '../service/Api_service.dart';
import 'car_viewmodel.dart';
import '../data/car_database_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CarListViewModel extends GetxController {
  List<CarViewModel>? posts = RxList<CarViewModel>();
  var isLoaded = false.obs;

  getData() async {
    // final result = await ApiService().getPosts();
    // if (result != null) {
    //   posts?.clear();
    //   posts?.addAll(result.map((p) => CarViewModel(car: p)).toList());
    //   // posts = result.map((p) => CarViewModel(car: p)).toList();
    //   print("getdata");
    //   isLoaded.value = true;
    // }
    final carDatabaseHelper = CarDatabaseHelper();

    var connectivityResult =  await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      // Fetch data from API
      final result = await ApiService().getPosts();

      // Internet connection is available, fetch data from the API
      if (result != null) {
        // Save data to local database
        await carDatabaseHelper.saveDataToDatabase(result);
        print("Saved data ");
      }
    }
      final localCars = await carDatabaseHelper.getDataFromDatabase();

      // Update posts and isLoaded
      posts?.clear();
      posts?.addAll(localCars.map((car) => CarViewModel(car: car)).toList());
      isLoaded.value = true;

      print("getData (DB)");
    }


  RxInt currentIndex = 0.obs;

  void onTabSelected(int index) {
    currentIndex.value = index;

    // Navigate to the corresponding page
    switch (index) {
      case 0:
        // Get.toNamed('/') For arrow above page
    Get.offAllNamed('/');
        break;
      case 1:
        Get.offAllNamed('/search'); // Navigate to the search page
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
