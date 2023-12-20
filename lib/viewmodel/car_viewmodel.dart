import '../model/car.dart';

class CarViewModel {
  final Car? car;

  CarViewModel({this.car});

  String get brand => car!.brand ?? "";
  String get model => car!.model ?? "";
  String get fuel => car!.fuel ?? "";
  String get options => car!.options ?? "";
  double get price => car!.price ?? 0.0;
  int get modelYear => car!.modelYear ?? 0;
  int get nrOfSeats => car!.nrOfSeats ?? 0;
  int get engineSize => car!.engineSize ?? 0;

  String get img => car?.img ?? "";
}