import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../model/rentals.dart';
import '../services/api_service.dart';
import '../data/rental_database_helper.dart';

class HistoryViewModel extends GetxController {
  List<Rental>? rentals = RxList<Rental>();

  getRentals() async {
    final rentalDatabaseHelper = RentalDatabaseHelper();

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final result = await ApiService().getRentals();
      if (result != null) {
        await rentalDatabaseHelper.saveDataToDatabase(result.cast<Rental>());
        print("Saved data ");
      }
    }
    final localRentals = await rentalDatabaseHelper.getDataFromDatabase();

    rentals?.clear();
    rentals?.addAll(localRentals!);
    print("getData (DB)");
  }
  @override
  void onInit() {
    super.onInit();
    getRentals();
  }
}
