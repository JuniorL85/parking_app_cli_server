import 'package:parking_app_cli/models/networked.dart';
import 'package:uuid/uuid.dart';

import 'person.dart';

enum VehicleType {
  car,
  motorcycle,
  other,
}

final uuid = Uuid();

class Vehicle extends Networked {
  Vehicle({
    required this.regNr,
    required this.vehicleType,
    required this.owner,
    String? id,
  })  : id = id ?? uuid.v4(),
        super(resource: 'vehicles');

  final String id;
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
