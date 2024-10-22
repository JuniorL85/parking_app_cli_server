import 'dart:math';

import 'person.dart';

enum VehicleType {
  car,
  motorcycle,
  other,
}

int idGenerator() {
  Random random = Random();
  int randomNumber = random.nextInt(10000);
  return randomNumber;
}

class Vehicle {
  Vehicle({
    required this.regNr,
    required this.vehicleType,
    required this.owner,
    int? id,
  }) : id = id ?? idGenerator();

  final int id;
  final String regNr;
  final VehicleType vehicleType;
  final Person owner;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        id: json['id'] as int,
        regNr: json['regNr'] as String,
        vehicleType: VehicleType.values.byName(json['vehicleType']),
        owner: Person.fromJson(json['owner']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'regNr': regNr,
        'vehicleType': vehicleType.name,
        'owner': owner.toJson()
      };
}
