import 'dart:convert';

import 'package:cli_server/repositories/vehicle_repo.dart';
import 'package:cli_shared/cli_shared.dart';
import 'package:shelf/shelf.dart';

const _jsonHeaders = {
  'Content-Type': 'application/json',
};

final vehicleRepo = VehicleRepository.instance;

Future<Response> getAllVehicles(Request req) async {
  final vehicles = vehicleRepo.getAllVehicles().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(vehicles),
    headers: _jsonHeaders,
  );
}

Future<Response> getVehicleById(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final vehicle = Vehicle.fromJson(json);

  final vehicles = vehicleRepo
      .getAllVehicles()
      .where((p) => p.id == vehicle.id)
      .map((p) => p.toJson())
      .toList();
  return Response.ok(
    jsonEncode(vehicles),
    headers: _jsonHeaders,
  );
}

Future<Response> createVehicle(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final vehicle = Vehicle.fromJson(json);

  vehicleRepo.addVehicle(vehicle);

  return Response.ok('Vehicle added!');
}

Future<Response> updateVehicle(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final vehicle = Vehicle.fromJson(json);
  final queryParam = req.requestedUri.queryParameters;

  vehicleRepo.updateVehicles(vehicle, queryParam['oldRegNr']);

  return Response.ok('Vehicle with id: ${vehicle.id} updated!');
}

Future<Response> deleteVehicle(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final vehicle = Vehicle.fromJson(json);

  vehicleRepo.deleteVehicle(vehicle);

  return Response.ok('Vehicle with id: ${vehicle.id} deleted!');
}
