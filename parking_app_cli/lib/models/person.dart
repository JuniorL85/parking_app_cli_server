import 'package:parking_app_cli/models/networked.dart';

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}

class Person extends Networked {
  Person({
    required this.name,
    required this.socialSecurityNumber,
    String? id,
  })  : id = id ?? idGenerator(),
        super(resource: 'persons');

  final String id;
  String name;
  String socialSecurityNumber;

  @override
  Person deserialize(Map<String, dynamic> json) => Person.fromJson(json);

  @override
  Map<String, dynamic> serialize(item) => toJson();

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as String,
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
