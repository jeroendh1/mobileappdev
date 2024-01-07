import 'dart:convert';

List<Car> carFromJson(String str) =>
    List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
  int id;
  String brand;
  String model;
  String fuel;
  String options;
  String licensePlate;
  int engineSize;
  int modelYear;
  String since;
  double price;
  int nrOfSeats;
  String body;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.fuel,
    required this.options,
    required this.licensePlate,
    required this.engineSize,
    required this.modelYear,
    required this.since,
    required this.price,
    required this.nrOfSeats,
    required this.body
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        fuel: json["fuel"],
        options: json["options"],
        licensePlate: json["licensePlate"],
        engineSize: json["engineSize"],
        modelYear: json["modelYear"],
        since: json["since"],
        nrOfSeats: json["nrOfSeats"],
        price: json["price"],
        body: json['body'],
      );


    Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "model": model,
        "fuel": fuel,
        "options": options,
        "licensePlate":licensePlate,
        "engineSize":engineSize,
        "modelYear":modelYear,
        "since":since,
        "nrOfSeats":nrOfSeats,
        "price":price,
        "body":body
      };

}
