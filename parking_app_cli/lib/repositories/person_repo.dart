import 'dart:convert';

import '../logic/set_main.dart';
import '../models/person.dart';
import 'vehicle_repo.dart';
import 'package:http/http.dart' as http;

class PersonRepository extends SetMain {
  String host;
  String port;
  String resource;

  PersonRepository(
      {this.resource = 'persons',
      this.host = 'http://localhost',
      this.port = '8080'});

  final VehicleRepository vehicleRepository = VehicleRepository();

  List<Person> personList = [
    Person(
      name: 'Test Testsson',
      socialSecurityNumber: '131313131313',
    )
  ];

  Future<dynamic> addPerson(Person person) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.serialize(person)));

    return response;
  }

  Future<dynamic> getAllPersons() async {
    final uri = Uri.parse('$host:$port/$resource');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    return (json as List).map((person) => Person.fromJson(person)).toList();
  }

  Future<dynamic> updatePersons(Person person) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.serialize(person)));

    return response;
  }

  Future<dynamic> deletePerson(Person person) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.delete(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.serialize(person)));

    return response;
  }
}
