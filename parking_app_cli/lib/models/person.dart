import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Person {
  Person({
    required this.name,
    required this.socialSecurityNumber,
    int? id,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch;

  int id;
  String name;
  String socialSecurityNumber;

  Person deserialize(Map<String, dynamic> json) => Person.fromJson(json);

  Map<String, dynamic> serialize(item) => toJson();

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] as String,
      socialSecurityNumber: json['socialSecurityNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'socialSecurityNumber': socialSecurityNumber,
      };
}
