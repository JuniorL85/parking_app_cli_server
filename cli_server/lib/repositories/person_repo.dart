import 'package:cli_server/server_config.dart';

import 'package:cli_shared/cli_shared.dart';
import 'vehicle_repo.dart';

class PersonRepository {
  PersonRepository._privateConstructor();

  static final instance = PersonRepository._privateConstructor();

  final vehicle = VehicleRepository.instance;

  Box personList = ServerConfig.instance.store.box<Person>();

  Future<dynamic> addPerson(Person person) async {
    personList.put(person, mode: PutMode.insert);
    return person;
  }

  Future<dynamic> getAllPersons() async {
    return personList.getAll();
  }

  Future<dynamic> updatePersons(Person person) async {
    personList.put(person, mode: PutMode.update);
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
      final vehicleList = vehicle.getAllVehicles();

      final foundVehicleIndex = vehicleList.indexWhere(
          (p) => p.owner.socialSecurityNumber == person.socialSecurityNumber);

      if (foundVehicleIndex != -1) {
        await vehicle.deleteVehicle(vehicleList[foundVehicleIndex]);
      }
    }

    return person;
  }
}
