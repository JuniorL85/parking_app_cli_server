import 'dart:convert';

import 'package:cli_server/repositories/parking_repo.dart';
import 'package:cli_shared/cli_shared.dart';
import 'package:shelf/shelf.dart';

const _jsonHeaders = {
  'Content-Type': 'application/json',
};

final parkingRepo = ParkingRepository.instance;

Future<Response> getAllParkings(Request req) async {
  final parkings = parkingRepo.getAllParkings().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(parkings),
    headers: _jsonHeaders,
  );
}

Future<Response> getParkingById(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parking = Parking.fromJson(json);

  final parkings = parkingRepo
      .getAllParkings()
      .where((p) => p.id == parking.id)
      .map((p) => p.toJson())
      .toList();
  return Response.ok(
    jsonEncode(parkings),
    headers: _jsonHeaders,
  );
}

Future<Response> createParking(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parking = Parking.fromJson(json);

  parkingRepo.addParking(
      parking.vehicle!.regNr, parking.parkingSpace!.id, parking.endTime);

  return Response.ok('Parking added!');
}

Future<Response> updateParking(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parking = Parking.fromJson(json);

  parkingRepo.updateParkings(parking.vehicle!.regNr, parking.endTime);

  return Response.ok('Parking with id: ${parking.id} updated!');
}

Future<Response> deleteParking(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parking = Parking.fromJson(json);

  parkingRepo.deleteParkings(parking.vehicle!.regNr);

  return Response.ok('Parking with id: ${parking.id} deleted!');
}
