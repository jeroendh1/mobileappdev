import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/rental_database_helper.dart';
import '../model/rentals.dart';
import '../service/Api_service.dart';

class DamageReportController extends GetxController {
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

  makeDamageReport(image, rentalId)async {
    print('image');
    List<int> imageBytes = await image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    await ApiService().postImage(image);

  }

  @override
  void onInit() {
    super.onInit();
    getRentals();
  }

}
