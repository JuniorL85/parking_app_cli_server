import 'dart:convert';

import 'package:collection/src/iterable_extensions.dart';

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

  final VehicleRepository vehicleRepository = VehicleRepository.instance;

  List<Person> personList = [
    Person(
      name: 'Test Testsson',
      socialSecurityNumber: '131313131313',
    )
  ];

  Future<dynamic> addPerson(Person person) async {
    final uri = Uri.parse('$host:$port/$resource');

    await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.serialize(person)));
    // return personList.add(person);
  }

  Future<dynamic> getAllPersons() async {
    final uri = Uri.parse('$host:$port/$resource');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    print(json);

    return (json as List).map((person) => Person.fromJson(person)).toList();
    // if (personList.isNotEmpty) {
    //   for (var (index, person) in personList.indexed) {
    //     print(
    //         '${index + 1}. Id: ${person.id}\n Namn: ${person.name}\n  Personnummer: ${person.socialSecurityNumber}\n');
    //   }
    // } else {
    //   print('Inga personer att visa i nuläget. Testa att lägga till personer.');
    // }
  }

  Future<dynamic> updatePersons(Person person) async {
    final foundPersonIndex = personList.indexWhere(
        (pers) => pers.socialSecurityNumber == person.socialSecurityNumber);

    if (foundPersonIndex == -1) {
      getBackToMainPage('Finns ingen person med det angivna personnumret');
    }

    return personList[foundPersonIndex] = person;
  }

  Future<dynamic> deletePerson(String socialSecurityNumber) async {
    final personToDelete = personList.firstWhereOrNull(
        (person) => person.socialSecurityNumber == socialSecurityNumber);

    if (personToDelete != null) {
      final personToDeleteInVehicleListIndex = vehicleRepository.vehicleList
          .indexWhere((v) =>
              v.owner.socialSecurityNumber ==
              personToDelete.socialSecurityNumber);

      personList.remove(personToDelete);

      if (personToDeleteInVehicleListIndex != -1) {
        vehicleRepository.vehicleList
            .removeAt(personToDeleteInVehicleListIndex);
      }

      return print(
          'Du har raderat följande person: ${personToDelete.name} - ${personToDelete.socialSecurityNumber}');
    } else {
      getBackToMainPage('Finns ingen person med det angivna personnumret');
    }
  }
}
