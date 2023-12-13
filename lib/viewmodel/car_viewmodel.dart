import '../model/car.dart';

class CarViewModel {
  final Car? car;

  CarViewModel({this.car});

  String get brand {
    return car!.brand;
  }

  String get model {
    return car!.model;
  }
  String get fuel {
    return car!.fuel;
  }
  String get options {
    return car!.options;
  }
  double get price {
    return car!.price;
  }
  int get modelYear {
    return  car!.modelYear;
  }
  int get nrOfSeats {
    return  car!.nrOfSeats;
  }
  int get engineSize {
    return  car!.engineSize;
  }

  String get img {
    return car!.img!;
  }
}
