import 'package:cli_server/server_config.dart';
import 'package:cli_shared/cli_shared.dart';

class VehicleRepository {
  VehicleRepository._privateConstructor();

  static final instance = VehicleRepository._privateConstructor();

  Box vehicleList = ServerConfig.instance.store.box<Vehicle>();

  Future<dynamic> addVehicle(Vehicle vehicle) async {
    vehicleList.put(vehicle, mode: PutMode.insert);
    return vehicle;
  }

  getAllVehicles() {
    return vehicleList.getAll();
  }

  Future<dynamic> updateVehicles(Vehicle vehicle) async {
    vehicleList.put(vehicle, mode: PutMode.update);
    return vehicle;
  }

  Future<dynamic> deleteVehicle(Vehicle vehicle) async {
    Vehicle? vehicles = vehicleList.get(vehicle.id);

    if (vehicles != null) {
      vehicleList.remove(vehicle.id);
    }

    return vehicles;
  }
}
