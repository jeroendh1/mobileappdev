import 'package:mobileappdev/model/rentals.dart';

class Inspection {
  int id;
  String code;
  int odometer;
  String result;
  String photo;
  Rental? rental;

  Inspection({
    required this.id,
    required this.code,
    required this.odometer,
    required this.result,
    required this.photo,
    this.rental
  });

  // factory Inspection.fromJson(Map<String, dynamic> json) {
  //   return Inspection(
  //     id: json['id'],
  //     code: json['code'],
  //     odometer: json['odometer'],
  //     result: json['result'],
  //     photo: json['photo'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'odometer': odometer,
      'result': result,
      'photo': photo,
      'rental': rental,
    };
  }
}
