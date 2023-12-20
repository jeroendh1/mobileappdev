import 'package:get/get.dart';

import '../service/Api_service.dart';
import 'car_viewmodel.dart';
import '../data/car_database_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CarListViewModel extends GetxController {
  List<CarViewModel>? posts = RxList<CarViewModel>();
  var isLoaded = false.obs;

  getData() async {
    final carDatabaseHelper = CarDatabaseHelper();

    var connectivityResult =  await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      // Fetch data from API
      final result = await ApiService().getCars();

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



  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
