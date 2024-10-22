import 'package:parking_app_cli/models/networked.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Person extends Networked {
  Person({
    required this.name,
    required this.socialSecurityNumber,
    String? id,
  })  : id = id ?? uuid.v4(),
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
      name: json['name'] as String,
      socialSecurityNumber: json['socialSecurityNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'socialSecurityNumber': socialSecurityNumber,
      };
}
