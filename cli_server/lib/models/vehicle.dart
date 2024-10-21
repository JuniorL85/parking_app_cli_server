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
        vehicleType:
            // json['vehicleType'] as String,
            // VehicleType.values.firstWhere((e) => e.name == json['vehicleType']),
            VehicleType.values.byName(json['vehicleType']),
        owner: Person.fromJson(json['owner']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'regNr': regNr,
        'vehicleType': vehicleType.name,
        'owner': owner.toJson()
      };
}
