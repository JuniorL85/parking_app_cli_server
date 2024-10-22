import 'dart:math';

int idGenerator() {
  Random random = Random();
  int randomNumber = random.nextInt(10000);
  return randomNumber;
}

class ParkingSpace {
  ParkingSpace({
    required this.address,
    required this.pricePerHour,
    int? id,
  }) : id = id ?? idGenerator();

  final int id;
  final String address;
  final int pricePerHour;

  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      id: json['id'] as int,
      address: json['address'] as String,
      pricePerHour: json['pricePerHour'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'pricePerHour': pricePerHour,
      };
}
