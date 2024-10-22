import '../logic/set_main.dart';
import '../models/parking.dart';
import 'parking_space_repo.dart';
import 'vehicle_repo.dart';

class ParkingRepository extends SetMain {
  ParkingRepository._privateConstructor();

  static final instance = ParkingRepository._privateConstructor();

  final VehicleRepository vehicleRepository = VehicleRepository();
  final ParkingSpaceRepository parkingSpaceRepository =
      ParkingSpaceRepository();

  List<Parking> parkingList = [];

  void _calculateDuration(startTime, endTime, pricePerHour) {
    Duration interval = endTime.difference(startTime);
    final price = interval.inMinutes / 60 * pricePerHour;
    print('\nDitt pris kommer att bli: ${price.toStringAsFixed(2)}kr\n');
  }

  Future<dynamic> addParking(
      String regNr, String parkingPlaceId, DateTime endTime) async {
    try {
      final addVehicle = vehicleRepository.vehicleList
          .where(
              (vehicle) => vehicle.regNr.toUpperCase() == regNr.toUpperCase())
          .first;

      final addParkingSpace = parkingSpaceRepository.parkingSpaceList
          .where((p) => p.id == parkingPlaceId)
          .first;

      final addParking = Parking(
        vehicle: addVehicle,
        parkingSpace: addParkingSpace,
        startTime: DateTime.now(),
        endTime: endTime,
      );

      parkingList.add(addParking);
      return _calculateDuration(
          DateTime.now(), endTime, addParkingSpace.pricePerHour);
    } catch (err) {
      getBackToMainPage(
          'Det gick fel, du omdirigeras till startsidan, se till att du lagt till personer, fordon och parkeringsplatser innan du forsätter!');
    }
  }

  Future<dynamic> getAllParkings() async {
    if (parkingList.isNotEmpty) {
      // finns det några aktiva i listan och tiden har gått ut så tas dessa bort
      final foundActiveParkingIndex = parkingList.indexWhere(
        (activeParking) => (activeParking.endTime.microsecondsSinceEpoch <
            DateTime.now().microsecondsSinceEpoch),
      );

      if (foundActiveParkingIndex != -1) {
        final foundActiveParking = parkingList[foundActiveParkingIndex];
        deleteParkings(foundActiveParking.id, isFromGetAllParkings: true);
      }

      if (parkingList.isNotEmpty) {
        for (var (index, park) in parkingList.indexed) {
          print(
              '${index + 1}. Id: ${park.id}\n Parkering: ${park.parkingSpace.address}\n Time (start and end): ${park.startTime}-${park.endTime}\n RegNr: ${park.vehicle.regNr}\n');
        }
      } else {
        getBackToMainPage('');
      }
    } else {
      print('Inga parkeringar att visa för tillfället.....');
    }
  }

  Future<dynamic> updateParkings(int parkingId, DateTime endTime) async {
    final foundParkingIndex = parkingList.indexWhere((v) => v.id == parkingId);

    if (foundParkingIndex == -1) {
      getBackToMainPage('Finns ingen parkering med det angivna id');
    }

    final foundParking = parkingList[foundParkingIndex];

    foundParking.endTime = endTime;

    return _calculateDuration(
      foundParking.startTime,
      foundParking.endTime,
      foundParking.parkingSpace.pricePerHour,
    );
  }

  Future<dynamic> deleteParkings(int parkingId,
      {bool isFromGetAllParkings = false}) async {
    final foundParkingIndex = parkingList.indexWhere((v) => v.id == parkingId);

    if (foundParkingIndex == -1) {
      getBackToMainPage('Finns ingen parkering med det angivna id');
    }

    final removedParking = parkingList.removeAt(foundParkingIndex);

    if (!isFromGetAllParkings) {
      return print(
          'Du har raderat följande parkering: ${removedParking.id} - ${removedParking.startTime}-${removedParking.endTime}');
    }
  }
}
