import 'dart:convert';

import '../logic/set_main.dart';
import '../models/person.dart';
import '../models/vehicle.dart';
import 'package:http/http.dart' as http;

class VehicleRepository extends SetMain {
  String host;
  String port;
  String resource;

  VehicleRepository(
      {this.resource = 'vehicles',
      this.host = 'http://localhost',
      this.port = '8080'});

  List<Vehicle> vehicleList = [
    Vehicle(
      regNr: 'CDF990',
      vehicleType: VehicleType.car,
      owner: Person(
        name: 'Anders Andersson',
        socialSecurityNumber: '197811112222',
      ),
    )
  ];

  Future<dynamic> addVehicle(Vehicle vehicle) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vehicle.serialize(vehicle)));

    if (response.statusCode == 200) {
      print(
          'Fordon uppdaterat, välj att se alla i menyn för att se uppdateringen');
    }
  }

  Future<dynamic> getAllVehicles() async {
    final uri = Uri.parse('$host:$port/$resource');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    return (json as List).map((vehicle) => Vehicle.fromJson(vehicle)).toList();
  }

  Future<dynamic> updateVehicles(Vehicle vehicle, oldRegNr) async {
    final uri = Uri.parse('$host:$port/$resource/$oldRegNr');

    final response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vehicle.serialize(vehicle)));

    if (response.statusCode == 200) {
      print(
          'Fordon uppdaterad, välj att se alla i menyn för att se uppdateringen');
    }
  }

  Future<dynamic> deleteVehicle(Vehicle vehicle) async {
    final uri = Uri.parse('$host:$port/$resource');

    final response = await http.delete(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vehicle.serialize(vehicle)));

    if (response.statusCode == 200) {
      print(
          'Person raderad, välj att se alla i menyn för att se uppdateringen');
    }
  }
}
