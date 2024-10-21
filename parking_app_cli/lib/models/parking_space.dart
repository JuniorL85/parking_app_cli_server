import 'package:parking_app_cli/models/networked.dart';

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}

class ParkingSpace extends Networked {
  ParkingSpace({
    required this.address,
    required this.pricePerHour,
    String? id,
  })  : id = id ?? idGenerator(),
        super(resource: 'parkingSpace');

  final String id;
  final String address;
  final int pricePerHour;

  @override
  ParkingSpace deserialize(Map<String, dynamic> json) =>
      ParkingSpace.fromJson(json);

  @override
  Map<String, dynamic> serialize(item) => toJson();

  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      id: json['id'] as String,
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
