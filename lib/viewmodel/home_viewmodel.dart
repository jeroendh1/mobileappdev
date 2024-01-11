import 'package:get/get.dart';

import '../model/car.dart';
import '../service/Api_service.dart';
import '../data/car_database_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeViewModel extends GetxController {
  List<Car>? posts = RxList<Car>();
  List<Car>? originalPosts = RxList<Car>();

  var isLoaded = false.obs;

  getCars() async {
    final carDatabaseHelper = CarDatabaseHelper();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final result = await ApiService().getCars();

      if (result != null) {
        await carDatabaseHelper.saveDataToDatabase(result);
        print("Saved data ");
      }
    }

    originalPosts = await carDatabaseHelper.getDataFromDatabase();
    // originalPosts = localCars.map((car) => Car(car: car)).toList();

    posts?.clear();
    posts?.addAll(originalPosts!);
    isLoaded.value = true;

    print("getData (DB)");
  }
  // Check if the brand or model name contains the query value.
  void searchFilter(String query) {
    List<Car> filteredCars = originalPosts!.where((car) =>
    car.brand.toLowerCase().contains(query) ||
        car.model.toLowerCase().contains(query))
        .toList();

    posts?.assignAll(filteredCars);
  }

  void filterCars(int startYear, int endYear, String selectedFuelType, String selectedBody) {
    List<Car> filteredCars = originalPosts!
        .where((car) =>
    (car.modelYear >= startYear) &&
        (car.modelYear <= endYear) &&
        (selectedFuelType == 'All' || car.fuel.toLowerCase() == selectedFuelType.toLowerCase()) &&
        (selectedBody == 'All' || car.body.toLowerCase() == selectedBody.toLowerCase()))
        .toList();

    posts?.assignAll(filteredCars);
  }

  @override
  void onInit() {
    super.onInit();
    getCars();
  }
}
