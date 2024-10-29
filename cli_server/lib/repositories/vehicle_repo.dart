import 'package:cli_shared/cli_shared.dart';

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
  }
}
