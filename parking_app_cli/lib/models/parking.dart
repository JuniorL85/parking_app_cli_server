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
}
