class Customer {
  int id;
  String lastName;
  String firstName;

  Customer({
    required this.id,
    required this.lastName,
    required this.firstName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      lastName: json['lastName'],
      firstName: json['firstName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastName': lastName,
      'firstName': firstName,
    };
  }
}
