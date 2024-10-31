import 'package:objectbox/objectbox.dart';
import 'package:safe_int_id/safe_int_id.dart';

final safeId = safeIntId.incId();

@Entity()
class Person {
  Person(
      {required this.name, required this.socialSecurityNumber, this.id = -1});

  @Id()
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
