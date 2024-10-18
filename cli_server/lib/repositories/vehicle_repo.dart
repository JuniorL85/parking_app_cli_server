import '../models/person.dart';
import '../models/vehicle.dart';

class VehicleRepository {
  VehicleRepository._privateConstructor();

  static final instance = VehicleRepository._privateConstructor();

  List<Vehicle> vehicleList = [
    Vehicle(
      regNr: 'CDF990',
      vehicleType: VehicleType.car,
      owner: Person(
        name: 'Anders Andersson',
        socialSecurityNumber: '197811112222',
      ),
    )
  ];

  void addVehicle(Vehicle vehicle) {
    vehicleList.add(vehicle);
  }

  getAllVehicles() {
    // if (vehicleList.isNotEmpty) {
    //   for (var (index, vehicle) in vehicleList.indexed) {
    //     print(
    //         '${index + 1}. Id: ${vehicle.id}\n RegNr: ${vehicle.regNr}\n Ägare: ${vehicle.owner.name}-${vehicle.owner.socialSecurityNumber}\n Typ: ${vehicle.vehicleType.name}\n');
    //   }
    // } else {
    //   print('Finns inga fordon att visa just nu....');
    // }
    return vehicleList;
  }

  void updateVehicles(Vehicle vehicle, oldRegNr) {
    final foundVehicleIndex =
        vehicleList.indexWhere((v) => v.regNr == oldRegNr);

    if (foundVehicleIndex == -1) {
      // getBackToMainPage(
      //     'Finns inget fordon med det angivna registreringsnumret');
    }

    vehicleList[foundVehicleIndex] = vehicle;
  }

  void deleteVehicle(Vehicle vehicle) {
    final vehicleToDelete =
        vehicleList.firstWhere((v) => v.regNr == vehicle.regNr);

    vehicleList.remove(vehicleToDelete);

    // return print(
    //     'Du har raderat följande fordon: ${vehicleToDelete.regNr} - ${vehicleToDelete.vehicleType.name}');
  }
}
