import 'dart:convert';

import '../logic/set_main.dart';
import '../models/parking_space.dart';
import 'package:http/http.dart' as http;

class ParkingSpaceRepository extends SetMain {
  ParkingSpaceRepository._privateConstructor();

  static final instance = ParkingSpaceRepository._privateConstructor();

  String host = 'http://localhost';
  String port = '8080';
  String resource = 'parkingSpaces';

  List<ParkingSpace> parkingSpaceList = [
    ParkingSpace(
      address: 'Testgatan 10, 546 76 Göteborg',
      pricePerHour: 12,
    )
  ];

  Future<dynamic> addParkingSpace(ParkingSpace parkingSpace) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parkingSpace.serialize(parkingSpace)));

    return response;
  }

  Future<dynamic> getAllParkingSpaces() async {
    final uri = Uri.parse('$host:$port/$resource');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    return (json as List)
        .map((parkingSpaces) => ParkingSpace.fromJson(parkingSpaces))
        .toList();
  }

  Future<dynamic> updateParkingSpace(ParkingSpace parkingSpace) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parkingSpace.serialize(parkingSpace)));

    return response;
  }

  Future<dynamic> deleteParkingSpace(ParkingSpace parkingSpace) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.delete(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parkingSpace.serialize(parkingSpace)));

    return response;
  }
}
