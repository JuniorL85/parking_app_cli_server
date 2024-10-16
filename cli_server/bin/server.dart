import 'dart:convert';
import 'dart:io';

import 'package:cli_server/models/person.dart';
import 'package:cli_server/repositories/person_repo.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

const _jsonHeaders = {
  'Content-Type': 'application/json',
};

final personRepo = PersonRepository.instance;
// Configure routes.
final _router = Router()
  ..get('/persons', _getAllPersonsHandler)
  ..get('/persons/<id>', _getPersonById)
  ..post('/persons', _createPerson)
  ..put('/persons/<id>', _updatePerson)
  ..delete('/persons/<id>', _deletePerson);

Future<Response> _getAllPersonsHandler(Request req) async {
  final persons = personRepo.getAllPersons().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(persons),
    headers: _jsonHeaders,
  );
}

Response _getPersonById(Request req) {
  final id = req.params['id'];
  return Response.ok('$id\n');
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

  personRepo.deletePerson(person.id);

  return Response.ok('Person with id: ${person.id} deleted!');
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
