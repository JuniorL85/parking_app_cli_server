import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('Persons', () async {
    final response = await get(Uri.parse('$host/persons'));
    expect(response.statusCode, 200);
    print(response.body);
    // expect(response.body, 'hello\n');
  });

  test('getPersonById', () async {
    final response = await get(Uri.parse('$host/persons/1'));
    expect(response.statusCode, 200);
    // expect(response.body, response.body.contains('name'));
  });

  test('Vehicles', () async {
    final response = await get(Uri.parse('$host/vehicles'));
    expect(response.statusCode, 200);
    // expect(response.body, 'hello\n');
  });

  test('getVehicleById', () async {
    final response = await get(Uri.parse('$host/vehicles/1'));
    expect(response.statusCode, 200);
    // expect(response.body, 'hello\n');
  });

  test('ParkingSpaces', () async {
    final response = await get(Uri.parse('$host/parkingSpaces'));
    expect(response.statusCode, 200);
    // expect(response.body, 'hello\n');
  });

  test('getParkingSpaceById', () async {
    final response = await get(Uri.parse('$host/parkingSpaces/2'));
    expect(response.statusCode, 200);
    // expect(response.body, 'hello\n');
  });

  test('Parkings', () async {
    final response = await get(Uri.parse('$host/parkings'));
    expect(response.statusCode, 200);
    // expect(response.body, 'hello\n');
  });

  test('404', () async {
    final response = await get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });
}
