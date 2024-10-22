import 'dart:math';

import '../models/parking_space.dart';
import '../models/vehicle.dart';

int idGenerator() {
  Random random = Random();
  int randomNumber = random.nextInt(10000);
  return randomNumber;
}

class Parking {
  Parking({
    required this.vehicle,
    required this.parkingSpace,
    required this.startTime,
    required this.endTime,
    int? id,
  }) : id = id ?? idGenerator();

  final int id;
  final Vehicle vehicle;
  final ParkingSpace parkingSpace;
  final DateTime startTime;
  DateTime endTime;
}
