import 'package:uuid/uuid.dart';

import '../models/parking_space.dart';
import '../models/vehicle.dart';

final uuid = Uuid();

class Parking {
  Parking({
    required this.vehicle,
    required this.parkingSpace,
    required this.startTime,
    required this.endTime,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final Vehicle vehicle;
  final ParkingSpace parkingSpace;
  final DateTime startTime;
  DateTime endTime;

  Parking deserialize(Map<String, dynamic> json) => Parking.fromJson(json);

  Map<String, dynamic> serialize(item) => toJson();

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      vehicle: Vehicle.fromJson(json['vehicle']),
      parkingSpace: ParkingSpace.fromJson(json['parkingSpace']),
      startTime: json['startTime'] as DateTime,
      endTime: json['endTime'] as DateTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'vehicle': vehicle.toJson(),
        'parkingSpace': parkingSpace.toJson(),
        'startTime': startTime,
        'endTime': endTime,
      };
}
