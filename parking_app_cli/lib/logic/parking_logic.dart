import 'dart:io';

import '../repositories/parking_repo.dart';
import '../repositories/parking_space_repo.dart';
import '../repositories/vehicle_repo.dart';
import 'set_main.dart';

class ParkingLogic extends SetMain {
  final ParkingRepository parkingRepository = ParkingRepository.instance;
  final ParkingSpaceRepository parkingSpaceRepository =
      ParkingSpaceRepository.instance;
  final VehicleRepository vehicleRepository = VehicleRepository.instance;

  List<String> texts = [
    'Du har valt att hantera Parkeringar. Vad vill du göra?\n',
    '1. Skapa ny parkering\n',
    '2. Visa alla parkeringar\n',
    '3. Uppdatera parkeringar\n',
    '4. Ta bort parkeringar\n',
    '5. Gå tillbaka till huvudmenyn\n\n',
    'Välj ett alternativ (1-5): ',
  ];

  void runLogic(int chosenOption) {
    switch (chosenOption) {
      case 1:
        _addParkingLogic();
        break;
      case 2:
        _showAllParkingsLogic();
        break;
      case 3:
        _updateParkingLogic();
        break;
      case 4:
        _deleteParkingLogic();
        break;
      case 5:
        setMainPage();
        return;
      default:
        print('Ogiltigt val');
        return;
    }
  }

  String _getCorrectDate(String endTime) {
    DateTime dateToday = DateTime.now();
    String date = dateToday.toString().substring(0, 10);
    return '$date $endTime';
  }

  void _addParkingLogic() async {
    print('\nDu har valt att skapa en ny parkering\n');
    stdout.write('Fyll i registreringsnummer: ');
    var regNrInput = stdin.readLineSync();

    if (regNrInput == null || regNrInput.isEmpty) {
      stdout.write(
          'Du har inte fyllt i något registreringsnummer, vänligen fyll i ett registreringsnummer: ');
      regNrInput = stdin.readLineSync();
    }

    if (regNrInput == null || regNrInput.isEmpty) {
      setMainPage();
      return;
    }

    final foundActiveParking = parkingRepository.parkingList.indexWhere(
      (activeParking) => (activeParking.vehicle.regNr.toUpperCase() ==
              regNrInput!.toUpperCase() &&
          activeParking.endTime.microsecondsSinceEpoch >
              DateTime.now().microsecondsSinceEpoch),
    );

    if (foundActiveParking != -1) {
      getBackToMainPage(
          'Det finns redan en aktiv parkering på angivet regnr testa att uppdatera den istället, du skickas tillbaka till huvudsidan');
      return;
    } else {
      final foundMatchingRegNr = vehicleRepository.vehicleList.indexWhere(
          (vehicle) =>
              (vehicle.regNr.toUpperCase() == regNrInput!.toUpperCase()));

      if (foundMatchingRegNr != -1) {
        print('Valbara parkeringsplatser\n');
        parkingSpaceRepository.getAllParkingSpaces();

        stdout.write('Fyll i id för parkeringsplatsen: ');
        var parkingPlaceIdInput = stdin.readLineSync();

        if (parkingPlaceIdInput == null || parkingPlaceIdInput.isEmpty) {
          stdout.write(
              'Du har inte fyllt i något id för parkeringsplatsen, vänligen fyll i ett id för parkeringsplatsen: ');
          parkingPlaceIdInput = stdin.readLineSync();
        }

        if (parkingPlaceIdInput == null || parkingPlaceIdInput.isEmpty) {
          setMainPage();
          return;
        }

        final parkingSpaceIndexId = parkingSpaceRepository.parkingSpaceList
            .indexWhere((i) => i.id == parkingPlaceIdInput);

        if (parkingSpaceIndexId != -1) {
          stdout.write(
              'Fyll i sluttid för din parkering i korrekt format -> (hh:mm): ');
          var endTimeInput = stdin.readLineSync();

          if (endTimeInput == null || endTimeInput.isEmpty) {
            stdout.write(
                'Du har inte fyllt i någon sluttid för din parkering, vänligen fyll i en sluttid för din parkering: ');
            endTimeInput = stdin.readLineSync();
          }

          if (endTimeInput == null || endTimeInput.isEmpty) {
            setMainPage();
            return;
          }

          final formattedEndTimeInput =
              DateTime.tryParse(_getCorrectDate(endTimeInput));

          if (formattedEndTimeInput == null) {
            print('Du angav ett felaktigt tidsformat');
            setMainPage();
            return;
          }

          await parkingRepository.addParking(
            regNrInput.toUpperCase(),
            parkingPlaceIdInput,
            formattedEndTimeInput,
          );
          await parkingRepository.getAllParkings();

          stdout.write('Tryck på något för att komma till huvudmenyn');
          stdin.readLineSync();
          setMainPage();
        } else {
          getBackToMainPage('Finns ingen parkeringsplats med angivet id');
        }
      } else {
        getBackToMainPage('Finns inget matchande registreringsnummer');
      }
    }
  }

  void _showAllParkingsLogic() async {
    print('\nDu har valt att se alla parkeringar:\n');
    await parkingRepository.getAllParkings();
    stdout.write('Tryck på något för att komma till huvudmenyn');
    stdin.readLineSync();
    setMainPage();
  }

  void _updateParkingLogic() async {
    print('\nDu har valt att uppdatera en parkering\n');
    if (parkingRepository.parkingList.isEmpty) {
      getBackToMainPage(
          'Finns inga parkeringar att uppdatera, testa att lägga till en parkering först');
    }

    await parkingRepository.getAllParkings();

    stdout
        .write('Fyll i id för parkeringen på parkeringen du vill uppdatera: ');
    var parkingIdInput = stdin.readLineSync();

    if (parkingIdInput == null || parkingIdInput.isEmpty) {
      stdout.write(
          'Du har inte fyllt i något id för parkeringen, vänligen fyll i ett id för parkeringen: ');
      parkingIdInput = stdin.readLineSync();
    }

    if (parkingIdInput == null || parkingIdInput.isEmpty) {
      setMainPage();
      return;
    }

    final foundParkingIndexId = parkingRepository.parkingList
        .indexWhere((i) => (i.id == parkingIdInput));

    if (foundParkingIndexId != -1) {
      print('Vill du uppdatera parkeringens sluttid? Annars tryck Enter: ');
      var endTimeInput = stdin.readLineSync();
      String endTime;
      if (endTimeInput == null || endTimeInput.isEmpty) {
        endTime = '';
        print('Du gjorde ingen ändring!');
      } else {
        endTime = endTimeInput;

        final formattedEndTimeInput =
            DateTime.tryParse(_getCorrectDate(endTime));

        if (formattedEndTimeInput == null) {
          print('Du angav ett felaktigt tidsformat');
          setMainPage();
          return;
        }

        await parkingRepository.updateParkings(
            parkingIdInput, formattedEndTimeInput);
      }

      print('\nFöljande parkeringar är kvar i listan\n');
      await parkingRepository.getAllParkings();

      stdout.write('Tryck på något för att komma till huvudmenyn');
      stdin.readLineSync();
      setMainPage();
    } else {
      getBackToMainPage('Finns ingen aktiv parkering med angivet id');
    }
  }

  void _deleteParkingLogic() async {
    print('\nDu har valt att ta bort en parkering\n');
    if (parkingRepository.parkingList.isEmpty) {
      getBackToMainPage(
          'Finns inga parkeringar att radera, testa att lägga till en parkering först');
    }

    await parkingRepository.getAllParkings();

    stdout.write('Fyll i id för parkeringen: ');
    var parkingIdInput = stdin.readLineSync();

    if (parkingIdInput == null || parkingIdInput.isEmpty) {
      stdout.write(
          'Du har inte fyllt i något id för parkeringen, vänligen fyll i ett id för parkeringen: ');
      parkingIdInput = stdin.readLineSync();
    }

    if (parkingIdInput == null || parkingIdInput.isEmpty) {
      setMainPage();
      return;
    }

    final foundParkingIndexId = parkingRepository.parkingList
        .indexWhere((i) => (i.id == parkingIdInput));

    if (foundParkingIndexId != -1) {
      await parkingRepository.deleteParkings(parkingIdInput);
      print('\nFöljande parkeringar är kvar i listan\n');
      await parkingRepository.getAllParkings();

      stdout.write('Tryck på något för att komma till huvudmenyn');
      stdin.readLineSync();
      setMainPage();
    } else {
      getBackToMainPage('Finns ingen aktiv parkering med angivet id');
    }
  }
}
