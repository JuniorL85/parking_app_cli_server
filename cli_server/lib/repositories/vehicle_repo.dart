import 'package:cli_server/server_config.dart';
import 'package:cli_shared/cli_shared.dart';

class VehicleRepository {
  VehicleRepository._privateConstructor();

  static final instance = VehicleRepository._privateConstructor();

  // List<Vehicle> vehicleList = [
  //   Vehicle(
  //     regNr: 'CDF990',
  //     vehicleType: VehicleType.car,
  //     owner: Person(
  //       name: 'Anders Andersson',
  //       socialSecurityNumber: '197811112222',
  //     ),
  //   )
  // ];
  Box vehicleList = ServerConfig.instance.store.box<Vehicle>();

  Future<dynamic> addVehicle(Vehicle vehicle) async {
    vehicleList.put(vehicle, mode: PutMode.insert);
    return vehicle;
  }

  getAllVehicles() {
    return vehicleList.getAll();
  }

  Future<dynamic> updateVehicles(Vehicle vehicle) async {
    Vehicle? vehicles = vehicleList.get(vehicle.id);

    if (vehicles != null) {
      vehicleList.put(vehicle.id, mode: PutMode.update);
    }

    return vehicles;
  }

  Future<dynamic> deleteVehicle(Vehicle vehicle) async {
    // final vehicleToDelete =
    //     vehicleList.firstWhere((v) => v.regNr == vehicle.regNr);
    Vehicle? vehicles = vehicleList.get(vehicle.id);

    if (vehicles != null) {
      vehicleList.remove(vehicle.id);
    }

    return vehicles;
  }
}
