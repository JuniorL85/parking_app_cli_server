import 'package:cli_server/server_config.dart';

import 'package:cli_shared/cli_shared.dart';
import 'vehicle_repo.dart';

class PersonRepository {
  PersonRepository._privateConstructor();

  static final instance = PersonRepository._privateConstructor();

  final vehicleList = VehicleRepository.instance.vehicleList;

  Box personList = ServerConfig.instance.store.box<Person>();

  Future<dynamic> addPerson(Person person) async {
    personList.put(person, mode: PutMode.insert);
    return person;
  }

  Future<dynamic> getAllPersons() async {
    return personList.getAll();
  }

  Future<dynamic> updatePersons(Person person) async {
    Person? personToUpdate = personList.get(person.id);

    if (personToUpdate != null) {
      personList.put(person, mode: PutMode.update);
    }

    return person;
  }

  Future<dynamic> deletePerson(Person person) async {
    Person? personToDelete = personList.get(person.id);

    if (personToDelete != null) {
      personList.remove(person.id);
      // final personToDeleteInVehicleList = vehicleList
      //     .where((v) =>
      //         v.owner!.socialSecurityNumber ==
      //         personToDelete.socialSecurityNumber)
      //     .first;
      final personToDeleteInVehicleList = vehicleList.get(person.id);

      if (personToDeleteInVehicleList != null) {
        vehicleList.remove(personToDeleteInVehicleList.id);
      }
    }

    return person;
    // final personToDelete = personList.firstWhereOrNull(
    //     (person) => person.socialSecurityNumber == socialSecurityNumber);

    // if (personToDelete != null) {
    //   final personToDeleteInVehicleListIndex = vehicleRepository.vehicleList
    //       .indexWhere((v) =>
    //           v.owner!.socialSecurityNumber ==
    //           personToDelete.socialSecurityNumber);

    //   personList.remove(personToDelete);

    //   if (personToDeleteInVehicleListIndex != -1) {
    //     vehicleRepository.vehicleList
    //         .removeAt(personToDeleteInVehicleListIndex);
    //   }
    // } else {
    //   // getBackToMainPage('Finns ingen person med det angivna personnumret');
    // }
  }
}
