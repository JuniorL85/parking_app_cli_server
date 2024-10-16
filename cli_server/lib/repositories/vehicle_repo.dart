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

  Future<dynamic> addVehicle(Vehicle vehicle) async {
    return vehicleList.add(vehicle);
  }

  Future<dynamic> getAllVehicles() async {
    if (vehicleList.isNotEmpty) {
      for (var (index, vehicle) in vehicleList.indexed) {
        print(
            '${index + 1}. Id: ${vehicle.id}\n RegNr: ${vehicle.regNr}\n Ägare: ${vehicle.owner.name}-${vehicle.owner.socialSecurityNumber}\n Typ: ${vehicle.vehicleType.name}\n');
      }
    } else {
      print('Finns inga fordon att visa just nu....');
    }
  }

  Future<dynamic> updateVehicles(Vehicle vehicle, oldRegNr) async {
    final foundVehicleIndex =
        vehicleList.indexWhere((v) => v.regNr == oldRegNr);

    if (foundVehicleIndex == -1) {
      // getBackToMainPage(
      //     'Finns inget fordon med det angivna registreringsnumret');
    }

    return vehicleList[foundVehicleIndex] = vehicle;
  }

  Future<dynamic> deleteVehicle(String regNr) async {
    final vehicleToDelete =
        vehicleList.firstWhere((vehicle) => vehicle.regNr == regNr);

    vehicleList.remove(vehicleToDelete);

    return print(
        'Du har raderat följande fordon: ${vehicleToDelete.regNr} - ${vehicleToDelete.vehicleType.name}');
  }
}
