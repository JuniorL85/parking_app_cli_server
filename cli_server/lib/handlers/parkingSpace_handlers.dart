import 'dart:convert';

import 'package:cli_server/repositories/parking_space_repo.dart';
import 'package:cli_shared/cli_shared.dart';
import 'package:shelf/shelf.dart';

const _jsonHeaders = {
  'Content-Type': 'application/json',
};

final parkingSpaceRepo = ParkingSpaceRepository.instance;

Future<Response> getAllParkingSpaces(Request req) async {
  final parkingSpaces =
      parkingSpaceRepo.getAllParkingSpaces().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(parkingSpaces),
    headers: _jsonHeaders,
  );
}

Future<Response> getParkingSpaceById(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parkingSpace = ParkingSpace.fromJson(json);

  final parkingSpaces = parkingSpaceRepo
      .getAllParkingSpaces()
      .where((p) => p.id == parkingSpace.id)
      .map((p) => p.toJson())
      .toList();
  return Response.ok(
    jsonEncode(parkingSpaces),
    headers: _jsonHeaders,
  );
}

Future<Response> createParkingSpace(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parkingSpace = ParkingSpace.fromJson(json);

  parkingSpaceRepo.addParkingSpace(parkingSpace);

  return Response.ok('ParkingSpace added!');
}

Future<Response> updateParkingSpace(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parkingSpace = ParkingSpace.fromJson(json);

  parkingSpaceRepo.updateParkingSpace(parkingSpace);

  return Response.ok('ParkingSpace with id: ${parkingSpace.id} updated!');
}

Future<Response> deleteParkingSpace(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parkingSpace = ParkingSpace.fromJson(json);

  parkingSpaceRepo.deleteParkingSpace(parkingSpace);

  return Response.ok('ParkingSpace with id: ${parkingSpace.id} deleted!');
}
