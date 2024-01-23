import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../service/Api_service.dart';

class DamageReportController extends GetxController {

  makeDamageReport(image)async {
    print('image');
    List<int> imageBytes = await image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    await ApiService().postImage(image);

  }
}
