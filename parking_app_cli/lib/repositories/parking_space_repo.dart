import 'dart:convert';

import '../logic/set_main.dart';
import '../models/parking_space.dart';
import 'package:http/http.dart' as http;

class ParkingSpaceRepository extends SetMain {
  String host;
  String port;
  String resource;

  ParkingSpaceRepository(
      {this.resource = 'parkingSpaces',
      this.host = 'http://localhost',
      this.port = '8080'});

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
