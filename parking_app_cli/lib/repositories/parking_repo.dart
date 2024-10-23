import 'dart:convert';

import '../logic/set_main.dart';
import '../models/parking.dart';
import 'parking_space_repo.dart';
import 'vehicle_repo.dart';

import 'package:http/http.dart' as http;

class ParkingRepository extends SetMain {
  ParkingRepository._privateConstructor();

  static final instance = ParkingRepository._privateConstructor();

  String host = 'http://localhost';
  String port = '8080';
  String resource = 'parkings';

  final VehicleRepository vehicleRepository = VehicleRepository.instance;
  final ParkingSpaceRepository parkingSpaceRepository =
      ParkingSpaceRepository.instance;

  List<Parking> parkingList = [];

  void _calculateDuration(startTime, endTime, pricePerHour) {
    Duration interval = endTime.difference(startTime);
    final price = interval.inMinutes / 60 * pricePerHour;
    print('\nDitt pris kommer att bli: ${price.toStringAsFixed(2)}kr\n');
  }

  Future<dynamic> addParking(Parking parking) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parking.serialize(parking)));

    return response;
    // try {
    //   final addVehicle = vehicleRepository.vehicleList
    //       .where(
    //           (vehicle) => vehicle.regNr.toUpperCase() == regNr.toUpperCase())
    //       .first;

    //   final addParkingSpace = parkingSpaceRepository.parkingSpaceList
    //       .where((p) => p.id == parkingPlaceId)
    //       .first;

    //   final addParking = Parking(
    //     vehicle: addVehicle,
    //     parkingSpace: addParkingSpace,
    //     startTime: DateTime.now(),
    //     endTime: endTime,
    //   );

    //   parkingList.add(addParking);
    //   return _calculateDuration(
    //       DateTime.now(), endTime, addParkingSpace.pricePerHour);
    // } catch (err) {
    //   getBackToMainPage(
    //       'Det gick fel, du omdirigeras till startsidan, se till att du lagt till personer, fordon och parkeringsplatser innan du forsätter!');
    // }
  }

  Future<dynamic> getAllParkings() async {
    final uri = Uri.parse('$host:$port/$resource');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    return (json as List)
        .map((parkingSpaces) => Parking.fromJson(parkingSpaces))
        .toList();
    // if (parkingList.isNotEmpty) {
    //   // finns det några aktiva i listan och tiden har gått ut så tas dessa bort
    //   final foundActiveParkingIndex = parkingList.indexWhere(
    //     (activeParking) => (activeParking.endTime.microsecondsSinceEpoch <
    //         DateTime.now().microsecondsSinceEpoch),
    //   );

    //   if (foundActiveParkingIndex != -1) {
    //     final foundActiveParking = parkingList[foundActiveParkingIndex];
    //     deleteParkings(foundActiveParking.id);
    //   }

    //   if (parkingList.isNotEmpty) {
    //     for (var (index, park) in parkingList.indexed) {
    //       print(
    //           '${index + 1}. Id: ${park.id}\n Parkering: ${park.parkingSpace.address}\n Time (start and end): ${park.startTime}-${park.endTime}\n RegNr: ${park.vehicle.regNr}\n');
    //     }
    //   } else {
    //     getBackToMainPage('');
    //   }
    // } else {
    //   print('Inga parkeringar att visa för tillfället.....');
    // }
  }

  Future<dynamic> updateParkings(Parking parking) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parking.serialize(parking)));

    return response;
  }

  Future<dynamic> deleteParkings(Parking parking) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parking.serialize(parking)));

    return response;
  }
}
