import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobileappdev/model/rentals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/customer.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';

class ReservationController extends GetxController {

  Future<dynamic> makeReservation(String fromDate, String toDate, String address, car)async {

    DateTime date_fromDate =  DateTime.parse('$fromDate 08:00:00.000');
    DateTime date_toDate =  DateTime.parse('$toDate 08:00:00.000');
    if (date_toDate.isBefore(date_fromDate)) return 'Geen geldige datum';

    NotificationService notificationService = Get.put(NotificationService());


    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? customerId = _prefs.getInt('customerId') ?? 0;
    String? firstName = _prefs.getString('firstName') ?? '';
    String? lastName = _prefs.getString('lastName') ?? '';
    Customer customer = Customer(id: customerId, lastName: lastName, firstName: firstName);

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
        customer: customer
      );
      await ApiService().createRental(rental);
      notificationService.cancelMakeReservationNotification();
      notificationService.scheduleNotificationForDeliveryDay(111, date_fromDate, 'Bezorging van ${car.brand}', 'De auto wordt vandaag bezorgd!');
      notificationService.scheduleNotificationForDeliveryDay(222,date_toDate, 'Ophalen van ${car.brand}', 'De auto wordt vandaag opgehaald!');
      return true;
    } catch (e) {
      print('Error: $e');
      return 'Er is iets fout gegaan';
    }
  }
}
