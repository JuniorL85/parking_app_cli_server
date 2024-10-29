import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class Person {
  Person({
    required this.name,
    required this.socialSecurityNumber,
    String? id,
  }) : id = id ?? _uuid.v4();

  String id;
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
