import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/rental_database_helper.dart';
import '../model/rentals.dart';
import '../services/api_service.dart';

class DamageReportController extends GetxController {
  List<Rental>? rentals = RxList<Rental>();

  getRentals() async {
    final rentalDatabaseHelper = RentalDatabaseHelper();

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final result = await ApiService().getRentals();
      if (result != null) {
        await rentalDatabaseHelper.saveDataToDatabase(result.cast<Rental>());
      }
    }
    final localRentals = await rentalDatabaseHelper.getDataFromDatabase();

    rentals?.clear();
    rentals?.addAll(localRentals);
  }

  makeDamageReport(image, rentalId)async {
    List<int> imageBytes = await image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    await ApiService().postImage(base64Image, rentalId);

  }

  @override
  void onInit() {
    super.onInit();
    getRentals();
  }

}
