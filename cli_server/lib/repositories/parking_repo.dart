import 'package:cli_server/server_config.dart';
import 'package:cli_shared/cli_shared.dart';
import 'parking_space_repo.dart';

class ParkingRepository {
  ParkingRepository._privateConstructor();

  static final instance = ParkingRepository._privateConstructor();

  final parkingSpaceList = ParkingSpaceRepository.instance.parkingSpaceList;

  Box parkingList = ServerConfig.instance.store.box<Parking>();

  Future<dynamic> addParking(Parking parking) async {
    parkingList.put(parking, mode: PutMode.insert);
    return parking;
  }

  getAllParkings() {
    return parkingList.getAll();
  }

  Future<dynamic> updateParkings(Parking parking) async {
    parkingList.put(parking, mode: PutMode.update);
    return parking;
  }

  Future<dynamic> deleteParkings(Parking parking) async {
    Parking? parkings = parkingList.get(parking.id);

    if (parkings != null) {
      parkingList.remove(parking.id);
    }

    return parkings;
  }
}
