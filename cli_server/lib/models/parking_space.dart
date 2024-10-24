import 'package:uuid/uuid.dart';

final uuid = Uuid();

class ParkingSpace {
  ParkingSpace({
    required this.address,
    required this.pricePerHour,
    required this.id,
  });

  int id;
  final String address;
  final int pricePerHour;

  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      id: json['id'] as int,
      address: json['address'] as String,
      pricePerHour: json['pricePerHour'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'pricePerHour': pricePerHour,
      };
}
