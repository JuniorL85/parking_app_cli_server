import 'package:cli_server/server_config.dart';
import 'package:cli_shared/cli_shared.dart';

class ParkingSpaceRepository {
  ParkingSpaceRepository._privateConstructor();

  static final instance = ParkingSpaceRepository._privateConstructor();

  // List<ParkingSpace> parkingSpaceList = [
  //   ParkingSpace(
  //     id: 1234,
  //     address: 'Testgatan 10, 546 76 Göteborg',
  //     pricePerHour: 12,
  //   )
  // ];
  Box parkingSpaceList = ServerConfig.instance.store.box<ParkingSpace>();

  Future<dynamic> addParkingSpace(ParkingSpace parkingSpace) async {
    parkingSpaceList.put(parkingSpace, mode: PutMode.insert);
    return parkingSpace;
  }

  getAllParkingSpaces() {
    return parkingSpaceList.getAll();
  }

  Future<dynamic> updateParkingSpace(ParkingSpace parkingSpace) async {
    // final foundParkingSpaceIndex =
    //     parkingSpaceList.indexWhere((v) => v.id == parkingSpace.id);

    // if (foundParkingSpaceIndex == -1) {
    //   // getBackToMainPage('Finns ingen parkeringsplats med det angivna id');
    // }

    // parkingSpaceList[foundParkingSpaceIndex] = parkingSpace;
    ParkingSpace? parkingSpaces = parkingSpaceList.get(parkingSpace.id);

    if (parkingSpaces != null) {
      parkingSpaceList.put(parkingSpace, mode: PutMode.update);
    }

    return parkingSpace;
  }

  Future<dynamic> deleteParkingSpace(ParkingSpace parkingSpace) async {
    // final parkingSpaceToDelete =
    //     parkingSpaceList.firstWhere((parking) => parking.id == parkingSpace.id);

    // parkingSpaceList.remove(parkingSpaceToDelete);
    ParkingSpace? parkingSpaces = parkingSpaceList.get(parkingSpace.id);

    if (parkingSpaces != null) {
      parkingSpaceList.remove(parkingSpace.id);
    }

    return parkingSpace;
  }
}
