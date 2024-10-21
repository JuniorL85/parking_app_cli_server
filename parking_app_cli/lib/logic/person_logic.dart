import 'dart:io';

import '../models/person.dart';
import '../repositories/person_repo.dart';
import 'set_main.dart';

class PersonLogic extends SetMain {
  final PersonRepository personRepository = PersonRepository();

  List<String> texts = [
    'Du har valt att hantera Personer. Vad vill du göra?\n',
    '1. Skapa ny person\n',
    '2. Visa alla personer\n',
    '3. Uppdatera person\n',
    '4. Ta bort person\n',
    '5. Gå tillbaka till huvudmenyn\n\n',
    'Välj ett alternativ (1-5): ',
  ];

  void runLogic(int chosenOption) {
    switch (chosenOption) {
      case 1:
        _addPersonLogic();
        break;
      case 2:
        _showAllPersonsLogic();
        break;
      case 3:
        _updatePersonsLogic();
        break;
      case 4:
        _deletePersonLogic();
        break;
      case 5:
        setMainPage();
        return;
      default:
        print('Ogiltigt val');
        return;
    }
  }

  void _addPersonLogic() async {
    print('\nDu har valt att skapa en ny person\n');
    stdout.write('Fyll i namn: ');
    var nameInput = stdin.readLineSync();

    if (nameInput == null || nameInput.isEmpty) {
      stdout
          .write('Du har inte fyllt i något namn, vänligen fyll i ett namn: ');
      nameInput = stdin.readLineSync();
    }

    // Dubbelkollar så inga tomma värden skickas
    if (nameInput == null || nameInput.isEmpty) {
      setMainPage();
      return;
    }

    stdout.write('Fyll i personnummer (12 siffror utan bindestreck): ');
    var socialSecurityNrInput = stdin.readLineSync();

    if (socialSecurityNrInput == null || socialSecurityNrInput.isEmpty) {
      stdout.write(
          'Du har inte fyllt i något personnummer, vänligen fyll i ett personnummer: ');
      socialSecurityNrInput = stdin.readLineSync();
    }

    // Dubbelkollar så inga tomma värden skickas
    if (socialSecurityNrInput == null || socialSecurityNrInput.isEmpty) {
      setMainPage();
      return;
    }

    final res = await personRepository.addPerson(
        Person(name: nameInput, socialSecurityNumber: socialSecurityNrInput));

    if (res.statusCode == 200) {
      print('Person tillagd, välj att se alla i menyn för att se personer');
    } else {
      print('Något gick fel du omdirigeras till huvudmenyn');
    }
    setMainPage();
  }

  _showAllPersonsLogic() async {
    final personList = await personRepository.getAllPersons();
    if (personList.isNotEmpty) {
      for (var person in personList) {
        print(
            'Id: ${person.id}\n Namn: ${person.name}\n  Personnummer: ${person.socialSecurityNumber}\n');
      }
    } else {
      print('Inga personer att visa i nuläget. Testa att lägga till personer.');
    }
    stdout.write('Tryck på något för att komma till huvudmenyn');
    stdin.readLineSync();
    setMainPage();
  }

  void _updatePersonsLogic() async {
    print('\nDu har valt att uppdatera en person\n');
    final personList = await personRepository.getAllPersons();
    if (personList.isEmpty) {
      getBackToMainPage(
          'Finns inga personer att uppdatera, testa att lägga till en person först');
    }
    stdout.write(
        'Fyll i personnummer på personen du vill uppdatera (12 siffror utan bindestreck): ');
    var socialSecurityNrInput = stdin.readLineSync();

    if (socialSecurityNrInput == null || socialSecurityNrInput.isEmpty) {
      stdout.write(
          'Du har inte fyllt i något personnummer, vänligen fyll i ett personnummer: ');
      socialSecurityNrInput = stdin.readLineSync();
    }

    // Dubbelkollar så inga tomma värden skickas
    if (socialSecurityNrInput == null || socialSecurityNrInput.isEmpty) {
      setMainPage();
      return;
    }

    final foundPersonIndex = personList
        .indexWhere((i) => i.socialSecurityNumber == socialSecurityNrInput);

    if (foundPersonIndex != -1) {
      print('Vill du uppdatera personens namn? Annars tryck Enter: ');
      var name = stdin.readLineSync();
      var updatedName;
      if (name == null || name.isEmpty) {
        updatedName = '';
        print('Du gjorde ingen ändring!');
      } else {
        updatedName = name;
        final res = await personRepository.updatePersons(Person(
            name: updatedName, socialSecurityNumber: socialSecurityNrInput));
        if (res.statusCode == 200) {
          print(
              'Person uppdaterad, välj att se alla i menyn för att se uppdateringen');
        } else {
          print('Något gick fel du omdirigeras till huvudmenyn');
        }
      }
      setMainPage();
    } else {
      getBackToMainPage('Finns ingen person med det angivna personnumret');
    }
  }

  void _deletePersonLogic() async {
    print('\nDu har valt att ta bort en person\n');
    final personList = await personRepository.getAllPersons();
    if (personList.isEmpty) {
      getBackToMainPage(
          'Finns inga personer att radera, testa att lägga till en person först');
    }
    stdout.write('Fyll i personnummer (12 siffror utan bindestreck): ');
    var socialSecurityNrInput = stdin.readLineSync();

    if (socialSecurityNrInput == null || socialSecurityNrInput.isEmpty) {
      stdout.write(
          'Du har inte fyllt i något personnummer, vänligen fyll i ett personnummer: ');
      socialSecurityNrInput = stdin.readLineSync();
    }

    // Dubbelkollar så inga tomma värden skickas
    if (socialSecurityNrInput == null || socialSecurityNrInput.isEmpty) {
      setMainPage();
      return;
    }

    final foundPersonIndex = personList
        .indexWhere((i) => i.socialSecurityNumber == socialSecurityNrInput);

    if (foundPersonIndex != -1) {
      final res =
          await personRepository.deletePerson(personList[foundPersonIndex]);

      if (res.statusCode == 200) {
        print('Person raderad, välj att se alla i menyn för att se personer');
      } else {
        print('Något gick fel du omdirigeras till huvudmenyn');
      }
      setMainPage();
    } else {
      getBackToMainPage('Finns ingen person med det angivna personnumret');
    }
  }
}
