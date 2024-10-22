import 'dart:math';

import 'package:parking_app_cli/models/networked.dart';

int idGenerator() {
  Random random = Random();
  int randomNumber = random.nextInt(10000);
  return randomNumber;
}

class ParkingSpace extends Networked {
  ParkingSpace({
    required this.address,
    required this.pricePerHour,
    int? id,
  })  : id = id ?? idGenerator(),
        super(resource: 'parkingSpace');

  final int id;
  final String address;
  final int pricePerHour;

  @override
  ParkingSpace deserialize(Map<String, dynamic> json) =>
      ParkingSpace.fromJson(json);

  @override
  Map<String, dynamic> serialize(item) => toJson();

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
