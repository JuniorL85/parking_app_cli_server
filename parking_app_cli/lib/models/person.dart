import 'dart:math';

import 'package:parking_app_cli/models/networked.dart';

int idGenerator() {
  Random random = Random();
  int randomNumber = random.nextInt(10000);
  return randomNumber;
}

class Person extends Networked {
  Person({
    required this.name,
    required this.socialSecurityNumber,
    int? id,
  })  : id = id ?? idGenerator(),
        super(resource: 'persons');

  final int id;
  String name;
  String socialSecurityNumber;

  @override
  Person deserialize(Map<String, dynamic> json) => Person.fromJson(json);

  @override
  Map<String, dynamic> serialize(item) => toJson();

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as int,
      name: json['name'] as String,
      socialSecurityNumber: json['socialSecurityNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'socialSecurityNumber': socialSecurityNumber,
      };
}
