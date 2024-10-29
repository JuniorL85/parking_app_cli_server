import 'dart:convert';

import 'package:cli_server/repositories/person_repo.dart';
import 'package:cli_shared/cli_shared.dart';
import 'package:shelf/shelf.dart';

const _jsonHeaders = {
  'Content-Type': 'application/json',
};

final personRepo = PersonRepository.instance;

Future<Response> getAllPersons(Request req) async {
  final persons = personRepo.getAllPersons().map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(persons),
    headers: _jsonHeaders,
  );
}

Future<Response> getPersonById(Request req) async {
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

Future<Response> createPerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  personRepo.addPerson(person);

  return Response.ok('Person added!');
}

Future<Response> updatePerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  personRepo.updatePersons(person);

  return Response.ok('Person with id: ${person.id} updated!');
}

Future<Response> deletePerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  personRepo.deletePerson(person.socialSecurityNumber);

  return Response.ok('Person with id: ${person.id} deleted!');
}
