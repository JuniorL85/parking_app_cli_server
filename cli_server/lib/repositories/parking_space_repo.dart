import 'package:cli_shared/cli_shared.dart';

class ParkingSpaceRepository {
  ParkingSpaceRepository._privateConstructor();

  static final instance = ParkingSpaceRepository._privateConstructor();

  List<ParkingSpace> parkingSpaceList = [
    ParkingSpace(
      id: 1234,
      address: 'Testgatan 10, 546 76 Göteborg',
      pricePerHour: 12,
    )
  ];

  void addParkingSpace(ParkingSpace parkingSpace) {
    parkingSpaceList.add(parkingSpace);
  }

  getAllParkingSpaces() {
    return parkingSpaceList;
  }

  void updateParkingSpace(ParkingSpace parkingSpace) {
    final foundParkingSpaceIndex =
        parkingSpaceList.indexWhere((v) => v.id == parkingSpace.id);

    if (foundParkingSpaceIndex == -1) {
      // getBackToMainPage('Finns ingen parkeringsplats med det angivna id');
    }

    parkingSpaceList[foundParkingSpaceIndex] = parkingSpace;
  }

  void deleteParkingSpace(ParkingSpace parkingSpace) {
    final parkingSpaceToDelete =
        parkingSpaceList.firstWhere((parking) => parking.id == parkingSpace.id);

    parkingSpaceList.remove(parkingSpaceToDelete);
  }
}
