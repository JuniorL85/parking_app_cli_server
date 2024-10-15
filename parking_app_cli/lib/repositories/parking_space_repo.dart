import '../logic/set_main.dart';
import '../models/parking_space.dart';

class ParkingSpaceRepository extends SetMain {
  ParkingSpaceRepository._privateConstructor();

  static final instance = ParkingSpaceRepository._privateConstructor();

  List<ParkingSpace> parkingSpaceList = [
    ParkingSpace(
      address: 'Testgatan 10, 546 76 Göteborg',
      pricePerHour: 12,
    )
  ];

  Future<dynamic> addParkingSpace(ParkingSpace parkingSpace) async {
    return parkingSpaceList.add(parkingSpace);
  }

  Future<dynamic> getAllParkingSpaces() async {
    if (parkingSpaceList.isNotEmpty) {
      for (var (index, parkingSpace) in parkingSpaceList.indexed) {
        print(
            '${index + 1}. Id: ${parkingSpace.id}\n Adress: ${parkingSpace.address}\n Pris per timme: ${parkingSpace.pricePerHour}\n');
      }
    } else {
      print('Inga parkeringsplatser att visa för tillfället....');
    }
  }

  Future<dynamic> updateParkingSpace(ParkingSpace parkingSpace) async {
    final foundParkingSpaceIndex =
        parkingSpaceList.indexWhere((v) => v.id == parkingSpace.id);

    if (foundParkingSpaceIndex == -1) {
      getBackToMainPage('Finns ingen parkeringsplats med det angivna id');
    }

    return parkingSpaceList[foundParkingSpaceIndex] = parkingSpace;
  }

  Future<dynamic> deleteParkingSpace(String parkingPlaceId) async {
    final parkingSpaceToDelete =
        parkingSpaceList.firstWhere((parking) => parking.id == parkingPlaceId);

    parkingSpaceList.remove(parkingSpaceToDelete);
    return print(
        'Du har raderat följande parkeringsplats: ${parkingSpaceToDelete.id} - ${parkingSpaceToDelete.address}');
  }
}
