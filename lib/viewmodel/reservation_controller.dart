import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobileappdev/model/car.dart';
import 'package:mobileappdev/model/rentals.dart';
import '../service/Api_service.dart';
import '../service/notification_service.dart';

class ReservationController extends GetxController {

  Future<dynamic> makeReservation(String fromDate, String toDate, String address, car)async {

    DateTime date_fromDate =  DateTime.parse('$fromDate 08:00:00.000');
    DateTime date_toDate =  DateTime.parse('$toDate 08:00:00.000');
    if (date_toDate.isBefore(date_fromDate)) return 'Geen geldige datum';

    NotificationService notificationService = Get.put(NotificationService());

    List<Location> locations;
    try {
      locations = await locationFromAddress(address);
    } catch (e) {
      print('Error: $e');
      return 'Geen geldige adres';
    }

    try {
      Rental rental = Rental(
        code: '',
        longitude: locations.first.longitude,
        latitude: locations.first.latitude,
        fromDate: fromDate,
        toDate: toDate,
        state: 'RESERVED',
        car: car,
      );
      await ApiService().createRental(rental);
      notificationService.scheduleNotificationForDeliveryDay(date_fromDate, 'Bezorging van ${car.brand}', 'De auto wordt vandaag bezorgd!');
      notificationService.scheduleNotificationForDeliveryDay(date_toDate, 'Ophalen van ${car.brand}', 'De auto wordt vandaag opgehaald!');
      return true;
    } catch (e) {
      print('Error: $e');
      return 'Er is iets fout gegaan';
    }
  }
}
