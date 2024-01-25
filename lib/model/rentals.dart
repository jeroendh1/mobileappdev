import 'dart:convert';
import '../model/car.dart';
import 'customer.dart';

List<Rental> rentalFromJson(String str) =>
    List<Rental>.from(json.decode(str).map((x) => Rental.fromJson(x)));

String rentalToJson(List<Rental> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rental {
  int? id;
  String code;
  double longitude;
  double latitude;
  String fromDate;
  String toDate;
  String state;
  Car? car;
  Customer? customer;
  int? car_id;

  Rental({
    this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    this.car,
    this.customer,
    this.car_id,
  });

  factory Rental.fromJsonWithCar(Map<String, dynamic> json) => Rental(
      id: json["id"],
      code: json["code"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      fromDate: json["fromDate"],
      toDate: json["toDate"],
      state: json["state"],
      car: Car.fromJson(json),
    );

  factory Rental.fromJson(Map<String, dynamic> json) => Rental(
    id: json["id"],
    code: json["code"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    state: json["state"],
    car_id:  json['car']['id'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "longitude": longitude,
    "latitude": latitude,
    "fromDate": fromDate,
    "toDate": toDate,
    "state": state,
    "car_id": car_id,
  };

  Map<String, dynamic> toJsonWithCar() => {
    "id": id,
    "code": code,
    "longitude": longitude,
    "latitude": latitude,
    "fromDate": fromDate,
    "toDate": toDate,
    "state": state,
    "car_id": car_id,
    "car": car,
    "customer": customer
  };
}
