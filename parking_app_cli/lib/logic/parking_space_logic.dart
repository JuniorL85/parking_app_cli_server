import 'dart:io';

import 'package:cli_shared/cli_shared.dart';
import '../repositories/parking_space_repo.dart';
import 'set_main.dart';

class ParkingSpaceLogic extends SetMain {
  final ParkingSpaceRepository parkingSpaceRepository =
      ParkingSpaceRepository.instance;

  List<String> texts = [
    'Du har valt att hantera Parkeringsplatser. Vad vill du göra?\n',
    '1. Skapa ny parkeringsplats\n',
    '2. Visa alla parkeringsplatser\n',
    '3. Uppdatera parkeringsplatser\n',
    '4. Ta bort parkeringsplatser\n',
    '5. Gå tillbaka till huvudmenyn\n\n',
    'Välj ett alternativ (1-5): ',
  ];

  void runLogic(int chosenOption) {
    switch (chosenOption) {
      case 1:
        _addParkingSpaceLogic();
        break;
      case 2:
        _showAllParkingSpacesLogic();
        break;
      case 3:
        _updateParkingSpacesLogic();
        break;
      case 4:
        _deleteParkingSpaceLogic();
        break;
      case 5:
        setMainPage(clearConsole: true);
        return;
      default:
        print('Ogiltigt val');
        return;
    }
  }

  void _addParkingSpaceLogic() async {
    print('\nDu har valt att skapa en ny parkeringsplats\n');

    stdout.write('Fyll i adress: ');
    var addressInput = stdin.readLineSync();

    if (addressInput == null || addressInput.isEmpty) {
      stdout.write(
          'Du har inte fyllt i något adress, vänligen fyll i ett adress: ');
      addressInput = stdin.readLineSync();
    }

    if (addressInput == null || addressInput.isEmpty) {
      setMainPage();
      return;
    }

    stdout.write('Fyll i pris per timme för parkeringsplatsen: ');
    var pricePerHourInput = stdin.readLineSync();

    if (pricePerHourInput == null || pricePerHourInput.isEmpty) {
      stdout.write(
          'Du har inte fyllt i något pris per timme för parkeringsplatsen, vänligen fyll i ett pris per timme för parkeringsplatsen: ');
      pricePerHourInput = stdin.readLineSync();
    }

    // Dubbelkollar så inga tomma värden skickas
    if (pricePerHourInput == null || pricePerHourInput.isEmpty) {
      setMainPage();
      return;
    }

    final pricePerHourFormatted = int.parse(pricePerHourInput);

    final res = await parkingSpaceRepository.addParkingSpace(ParkingSpace(
        address: addressInput, pricePerHour: pricePerHourFormatted));
    if (res.statusCode == 200) {
      print(
          'Parkeringsplats tillagd, välj att se alla i menyn för att se parkeringsplatser');
    } else {
      print('Något gick fel du omdirigeras till huvudmenyn');
    }
    setMainPage();
  }

  void _showAllParkingSpacesLogic() async {
    final parkingSpaceList = await parkingSpaceRepository.getAllParkingSpaces();
    if (parkingSpaceList.isNotEmpty) {
      for (var parkingSpace in parkingSpaceList) {
        print(
            '\x1B[36mId: ${parkingSpace.id}\n Adress: ${parkingSpace.address}\n Pris per timme: ${parkingSpace.pricePerHour}\x1B[0m\n');
      }
    } else {
      print('Inga parkeringsplatser att visa för tillfället....');
    }
    stdout.write('Tryck på något för att komma till huvudmenyn');
    stdin.readLineSync();
    setMainPage(clearConsole: true);
  }

  void _updateParkingSpacesLogic() async {
    print('\nDu har valt att uppdatera en parkeringsplats\n');
    final parkingSpaceList = await parkingSpaceRepository.getAllParkingSpaces();
    if (parkingSpaceList.isEmpty) {
      getBackToMainPage(
          'Finns inga parkeringsplatser att uppdatera, testa att lägga till en parkeringsplats först');
    }

    stdout.write('Fyll i id för parkeringsplatsen du vill uppdatera: ');
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

    int transformedId = int.parse(parkingPlaceIdInput);
    final foundParkingSpaceIdIndex =
        parkingSpaceList.indexWhere((i) => i.id == transformedId);

    if (foundParkingSpaceIdIndex != -1) {
      ParkingSpace oldParkingSpace = parkingSpaceList[foundParkingSpaceIdIndex];

      print(
          'Vill du uppdatera parkeringsplatsens adress? Annars tryck Enter: ');
      var addressInput = stdin.readLineSync();
      String updatedAddress;
      if (addressInput == null || addressInput.isEmpty) {
        updatedAddress = oldParkingSpace.address;
        print('Du gjorde ingen ändring!');
      } else {
        updatedAddress = addressInput;
        print('Du har ändrat adressen till $updatedAddress!');
      }

      print(
          'Vill du uppdatera parkeringsplatsens pris per timme? Annars tryck Enter: ');
      var pphInput = stdin.readLineSync();
      int updatedPph;
      if (pphInput == null || pphInput.isEmpty) {
        updatedPph = oldParkingSpace.pricePerHour;
        print('Du gjorde ingen ändring!');
      } else {
        updatedPph = int.parse(pphInput);
        print('Du har ändrat pris per timme till $updatedPph!');
      }

      final res = await parkingSpaceRepository.updateParkingSpace(ParkingSpace(
          id: int.parse(parkingPlaceIdInput),
          address: updatedAddress,
          pricePerHour: updatedPph));

      if (res.statusCode == 200) {
        print(
            'Parkeringsplats uppdaterad, välj att se alla i menyn för att se parkeringsplatser');
      } else {
        print('Något gick fel du omdirigeras till huvudmenyn');
      }
      setMainPage();
    } else {
      getBackToMainPage('Du angav ett felaktigt id');
    }
  }

  void _deleteParkingSpaceLogic() async {
    print('\nDu har valt att ta bort en parkeringsplats\n');
    final parkingSpaceList = await parkingSpaceRepository.getAllParkingSpaces();
    if (parkingSpaceList.isEmpty) {
      getBackToMainPage(
          'Finns inga parkeringsplatser att radera, testa att lägga till en parkeringsplats först');
    }

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

    int transformedId = int.parse(parkingPlaceIdInput);
    final foundParkingSpaceIdIndex =
        parkingSpaceList.indexWhere((i) => i.id == transformedId);

    if (foundParkingSpaceIdIndex != -1) {
      final res = await parkingSpaceRepository
          .deleteParkingSpace(parkingSpaceList[foundParkingSpaceIdIndex]);

      if (res.statusCode == 200) {
        print(
            'Parkeringsplats raderad, välj att se alla i menyn för att se parkeringsplatser');
      } else {
        print('Något gick fel du omdirigeras till huvudmenyn');
      }
      setMainPage();
    } else {
      getBackToMainPage('Du angav ett felaktigt id');
    }
  }
}
