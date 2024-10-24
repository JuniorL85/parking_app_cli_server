import 'dart:convert';
import 'dart:io';

import 'package:cli_server/models/parking.dart';
import 'package:cli_server/models/parking_space.dart';
import 'package:cli_server/models/person.dart';
import 'package:cli_server/models/vehicle.dart';
import 'package:cli_server/repositories/parking_repo.dart';
import 'package:cli_server/repositories/parking_space_repo.dart';
import 'package:cli_server/repositories/person_repo.dart';
import 'package:cli_server/repositories/vehicle_repo.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

const _jsonHeaders = {
  'Content-Type': 'application/json',
};

final personRepo = PersonRepository.instance;
final vehicleRepo = VehicleRepository.instance;
final parkingSpaceRepo = ParkingSpaceRepository.instance;
final parkingRepo = ParkingRepository.instance;
// Configure routes.
final _router = Router()
  ..get('/persons', _getAllPersons)
  ..get('/persons/<id>', _getPersonById)
  ..post('/persons', _createPerson)
  ..put('/persons', _updatePerson)
  ..delete('/persons', _deletePerson)
  ..get('/vehicles', _getAllVehicles)
  ..get('/vehicles/<id>', _getVehicleById)
  ..post('/vehicles', _createVehicle)
  ..put('/vehicles', _updateVehicle)
  ..delete('/vehicles', _deleteVehicle)
  ..get('/parkingSpaces', _getAllParkingSpaces)
  ..get('/parkingSpaces/<id>', _getParkingSpaceById)
  ..post('/parkingSpaces', _createParkingSpace)
  ..put('/parkingSpaces', _updateParkingSpace)
  ..delete('/parkingSpaces', _deleteParkingSpace)
  ..get('/parkings', _getAllParkings)
  ..get('/parkings/<id>', _getParkingById)
  ..post('/parkings', _createParking)
  ..put('/parkings', _updateParking)
  ..delete('/parkings', _deleteParking);

Future<Response> _getAllPersons(Request req) async {
  final persons = personRepo.getAllPersons().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(persons),
    headers: _jsonHeaders,
  );
}

Future<Response> _getPersonById(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  final persons = personRepo
      .getAllPersons()
      .where((p) => p.id == person.id)
      .map((p) => p.toJson())
      .toList();
  return Response.ok(
    jsonEncode(persons),
    headers: _jsonHeaders,
  );
}

Future<Response> _createPerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  personRepo.addPerson(person);

  return Response.ok('Person added!');
}

Future<Response> _updatePerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  personRepo.updatePersons(person);

  return Response.ok('Person with id: ${person.id} updated!');
}

Future<Response> _deletePerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  personRepo.deletePerson(person.socialSecurityNumber);

  return Response.ok('Person with id: ${person.id} deleted!');
}

Future<Response> _getAllVehicles(Request req) async {
  final vehicles = vehicleRepo.getAllVehicles().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(vehicles),
    headers: _jsonHeaders,
  );
}

Future<Response> _getVehicleById(Request req) async {
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

Future<Response> _createVehicle(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final vehicle = Vehicle.fromJson(json);

  vehicleRepo.addVehicle(vehicle);

  return Response.ok('Vehicle added!');
}

Future<Response> _updateVehicle(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final vehicle = Vehicle.fromJson(json);
  final queryParam = req.requestedUri.queryParameters;

  vehicleRepo.updateVehicles(vehicle, queryParam['oldRegNr']);

  return Response.ok('Vehicle with id: ${vehicle.id} updated!');
}

Future<Response> _deleteVehicle(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final vehicle = Vehicle.fromJson(json);

  vehicleRepo.deleteVehicle(vehicle);

  return Response.ok('Vehicle with id: ${vehicle.id} deleted!');
}

Future<Response> _getAllParkingSpaces(Request req) async {
  final parkingSpaces =
      parkingSpaceRepo.getAllParkingSpaces().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(parkingSpaces),
    headers: _jsonHeaders,
  );
}

Future<Response> _getParkingSpaceById(Request req) async {
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

Future<Response> _createParkingSpace(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parkingSpace = ParkingSpace.fromJson(json);

  parkingSpaceRepo.addParkingSpace(parkingSpace);

  return Response.ok('ParkingSpace added!');
}

Future<Response> _updateParkingSpace(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parkingSpace = ParkingSpace.fromJson(json);

  parkingSpaceRepo.updateParkingSpace(parkingSpace);

  return Response.ok('ParkingSpace with id: ${parkingSpace.id} updated!');
}

Future<Response> _deleteParkingSpace(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parkingSpace = ParkingSpace.fromJson(json);

  parkingSpaceRepo.deleteParkingSpace(parkingSpace);

  return Response.ok('ParkingSpace with id: ${parkingSpace.id} deleted!');
}

Future<Response> _getAllParkings(Request req) async {
  final parkings = parkingRepo.getAllParkings().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(parkings),
    headers: _jsonHeaders,
  );
}

Future<Response> _getParkingById(Request req) async {
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

Future<Response> _createParking(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parking = Parking.fromJson(json);

  parkingRepo.addParking(
      parking.vehicle.regNr, parking.parkingSpace.id, parking.endTime);

  return Response.ok('Parking added!');
}

Future<Response> _updateParking(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parking = Parking.fromJson(json);

  parkingRepo.updateParkings(parking.vehicle.regNr, parking.endTime);

  return Response.ok('Parking with id: ${parking.id} updated!');
}

Future<Response> _deleteParking(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final parking = Parking.fromJson(json);

  parkingRepo.deleteParkings(parking.vehicle.regNr);

  return Response.ok('Parking with id: ${parking.id} deleted!');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
