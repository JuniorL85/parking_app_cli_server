import 'person.dart';

enum VehicleType {
  car,
  motorcycle,
  other,
}

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}

class Vehicle {
  Vehicle({
    required this.regNr,
    required this.vehicleType,
    required this.owner,
    String? id,
  }) : id = id ?? idGenerator();

  final String id;
  final String regNr;
  final VehicleType vehicleType;
  final Person owner;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String,
      regNr: json['regNr'] as String,
      vehicleType: VehicleType.values.byName(json['vehicleType']),
      owner: Person(
          name: json['name'] as String,
          socialSecurityNumber: json['socialSecurityNumber'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'regNr': regNr,
        'vehicleType': vehicleType.name,
        'owner': Person(
            name: owner.name, socialSecurityNumber: owner.socialSecurityNumber),
      };
}
