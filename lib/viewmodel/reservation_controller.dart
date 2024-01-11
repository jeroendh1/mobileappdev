import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobileappdev/model/car.dart';
import 'package:mobileappdev/model/rentals.dart';
import '../service/Api_service.dart';

class ReservationController extends GetxController {

  makeReservation(String fromDate, String toDate, car)async {
    print('$fromDate tot $toDate');
    print(car.id);
    Rental rental = Rental(code: '', longitude: 0.0, latitude: 0.0, fromDate: fromDate, toDate: toDate, state: 'RESERVED', car: car);
    await ApiService().createRental(rental);

  }
}
