import '../model/car.dart';

class CarViewModel {
  final Car? car;

  CarViewModel({this.car});

  int get id => car!.id ?? 0;
  String get brand => car!.brand ?? "";
  String get model => car!.model ?? "";
  String get fuel => car!.fuel ?? "";
  String get options => car!.options ?? "";
  double get price => car!.price ?? 0.0;
  int get modelYear => car!.modelYear ?? 0;
  int get nrOfSeats => car!.nrOfSeats ?? 0;
  int get engineSize => car!.engineSize ?? 0;
  String get body => car!.body ?? "";

  String get img => brandToUrl[car?.brand.toLowerCase()] ?? 'assets/bmw.png';

  final brandToUrl = {
    'bmw': 'assets/bmw.png',
    'audi': 'assets/audi.png',
    'ford': 'assets/ford.png',
    'honda': 'assets/honda.png',
    'jeep': 'assets/jeep.png',
    'toyota': 'assets/toyota.png',
  };

}