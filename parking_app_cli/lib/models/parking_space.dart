import 'package:uuid/uuid.dart';

final uuid = Uuid();

class ParkingSpace {
  ParkingSpace({
    required this.address,
    required this.pricePerHour,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String address;
  final int pricePerHour;

  ParkingSpace deserialize(Map<String, dynamic> json) =>
      ParkingSpace.fromJson(json);

  Map<String, dynamic> serialize(item) => toJson();

  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      address: json['address'] as String,
      pricePerHour: json['pricePerHour'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'pricePerHour': pricePerHour,
      };
}
