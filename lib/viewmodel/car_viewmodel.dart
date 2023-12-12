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
  double get price {
    return car!.price;
  }

  String get img {
    return car!.img!;
  }
}
