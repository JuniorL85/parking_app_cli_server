import 'dart:convert';

import 'package:cli_server/repositories/person_repo.dart';
import 'package:cli_shared/cli_shared.dart';
import 'package:shelf/shelf.dart';

const _jsonHeaders = {
  'Content-Type': 'application/json',
};

final personRepo = PersonRepository.instance;

Future<Response> getAllPersons(Request req) async {
  final persons = await personRepo.getAllPersons();

  final personsPayload = persons.map((p) => p.toJson()).toList();
  return Response.ok(
    jsonEncode(personsPayload),
    headers: _jsonHeaders,
  );
}

Future<Response> getPersonById(Request req) async {
  return Response(200);
  // final data = await req.readAsString();
  // final json = jsonDecode(data);
  // final person = Person.fromJson(json);

  // final persons = await personRepo.getAllPersons();
  // return Response.ok(
  //   jsonEncode(persons),
  //   headers: _jsonHeaders,
  // );
}

Future<Response> createPerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  final personPayload = await personRepo.addPerson(person);

  return Response.ok(
    jsonEncode(personPayload),
    headers: _jsonHeaders,
  );
}

Future<Response> updatePerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  final personPayload = await personRepo.updatePersons(person);

  return Response.ok(
    jsonEncode(personPayload),
    headers: _jsonHeaders,
  );
}

Future<Response> deletePerson(Request req) async {
  final data = await req.readAsString();
  final json = jsonDecode(data);
  final person = Person.fromJson(json);

  final personPayload = await personRepo.deletePerson(person);

  return Response.ok(
    jsonEncode(personPayload),
    headers: _jsonHeaders,
  );
}
