import 'package:cli_server/server_config.dart';
import 'package:cli_shared/cli_shared.dart';
import 'parking_space_repo.dart';
import 'vehicle_repo.dart';

class ParkingRepository {
  ParkingRepository._privateConstructor();

  static final instance = ParkingRepository._privateConstructor();

  final vehicleList = VehicleRepository.instance.vehicleList;
  final parkingSpaceList = ParkingSpaceRepository.instance.parkingSpaceList;

  Box parkingList = ServerConfig.instance.store.box<Parking>();

  Future<dynamic> addParking(Parking parking) async {
    // final addVehicle = vehicleList
    //     .where((vehicle) => vehicle.regNr.toUpperCase() == regNr.toUpperCase())
    //     .first;
    final addVehicle = vehicleList.get(parking.vehicle!.id);

    // final addParkingSpace =
    //     parkingSpaceList.where((p) => p.id == parkingPlaceId).first;

    final addParkingSpace = parkingList.get(parking.parkingSpace!.id);

    final addParking = Parking(
      vehicle: addVehicle,
      parkingSpace: addParkingSpace,
      startTime: DateTime.now(),
      endTime: parking.endTime,
    );

    parkingList.put(addParking, mode: PutMode.insert);
    return addParking;
  }

  getAllParkings() {
    return parkingList.getAll();
  }

  Future<dynamic> updateParkings(String regNr, DateTime endTime) async {
    final existingParkingList = parkingList.getAll();
    final foundParkingIndex = existingParkingList
        .indexWhere((v) => v.vehicle!.regNr == regNr.toUpperCase());

    final foundParking = existingParkingList[foundParkingIndex];

    foundParking.endTime = endTime;
    parkingList.put(foundParking, mode: PutMode.update);
    return foundParking;
  }

  Future<dynamic> deleteParkings(String regNr) async {
    final existingParkingList = parkingList.getAll();
    final foundParkingIndex = existingParkingList
        .where((v) => v.vehicle!.regNr == regNr.toUpperCase())
        .first;

    parkingList.remove(foundParkingIndex.id);
    return regNr;
  }
}
