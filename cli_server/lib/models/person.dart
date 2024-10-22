import 'dart:math';

int idGenerator() {
  Random random = Random();
  int randomNumber = random.nextInt(10000);
  return randomNumber;
}

class Person {
  Person({
    required this.name,
    required this.socialSecurityNumber,
    int? id,
  }) : id = id ?? idGenerator();

  final int id;
  String name;
  String socialSecurityNumber;

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
