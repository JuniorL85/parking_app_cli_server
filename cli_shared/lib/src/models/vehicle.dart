import 'package:uuid/uuid.dart';

import 'person.dart';

enum VehicleType {
  car,
  motorcycle,
  other,
}

final _uuid = Uuid();

class Vehicle {
  Vehicle({
    required this.regNr,
    required this.vehicleType,
    required this.owner,
    String? id,
  }) : id = id ?? _uuid.v4();

  final String id;
  final String regNr;
  final VehicleType vehicleType;
  final Person owner;

  Vehicle deserialize(Map<String, dynamic> json) => Vehicle.fromJson(json);

  Map<String, dynamic> serialize(item) => toJson();

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        regNr: json['regNr'] as String,
        vehicleType: VehicleType.values.byName(json['vehicleType']),
        owner: Person.fromJson(json['owner']));
  }

  Map<String, dynamic> toJson() => {
        'regNr': regNr,
        'vehicleType': vehicleType.name,
        'owner': owner.toJson()
      };
}
