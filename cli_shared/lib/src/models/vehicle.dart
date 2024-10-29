import 'dart:convert';

import 'package:objectbox/objectbox.dart';

import 'person.dart';

enum VehicleType {
  car,
  motorcycle,
  other,
}

@Entity()
class Vehicle {
  Vehicle({
    required this.regNr,
    this.vehicleType,
    this.owner,
    int? id,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch;

  @Id()
  int id;
  final String regNr;
  VehicleType? vehicleType;
  @Transient()
  Person? owner;

  String? get ownerInDb {
    if (owner == null) {
      return null;
    } else {
      return jsonEncode(owner!.toJson());
    }
  }

  set ownerInDb(String? json) {
    if (json == null) {
      owner = null;
      return;
    }
    var decoded = jsonDecode(json);

    if (decoded != null) {
      owner = Person.fromJson(decoded);
    } else {
      owner = null;
    }
  }

  Vehicle deserialize(Map<String, dynamic> json) => Vehicle.fromJson(json);

  Map<String, dynamic> serialize(item) => toJson();

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        regNr: json['regNr'] as String,
        vehicleType: VehicleType.values.byName(json['vehicleType']),
        owner: json['owner'] != null ? Person.fromJson(json['owner']) : null);
  }

  Map<String, dynamic> toJson() => {
        'regNr': regNr,
        'vehicleType': vehicleType?.name,
        'owner': owner?.toJson()
      };
}
