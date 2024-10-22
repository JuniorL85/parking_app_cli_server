import 'dart:math';

import 'package:parking_app_cli/models/networked.dart';

import 'person.dart';

enum VehicleType {
  car,
  motorcycle,
  other,
}

int idGenerator() {
  // final now = DateTime.now();
  // return now.microsecondsSinceEpoch.toString();
  Random random = Random();
  int randomNumber = random.nextInt(10000);
  return randomNumber;
}

class Vehicle extends Networked {
  Vehicle({
    required this.regNr,
    required this.vehicleType,
    required this.owner,
    int? id,
  })  : id = id ?? idGenerator(),
        super(resource: 'vehicles');

  final int id;
  final String regNr;
  final VehicleType vehicleType;
  // final String vehicleType;
  final Person owner;

  @override
  Vehicle deserialize(Map<String, dynamic> json) => Vehicle.fromJson(json);

  @override
  Map<String, dynamic> serialize(item) => toJson();

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
