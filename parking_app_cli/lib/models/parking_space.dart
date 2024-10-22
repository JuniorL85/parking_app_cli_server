import 'package:parking_app_cli/models/networked.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class ParkingSpace extends Networked {
  ParkingSpace({
    required this.address,
    required this.pricePerHour,
    String? id,
  })  : id = id ?? uuid.v4(),
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
      address: json['address'] as String,
      pricePerHour: json['pricePerHour'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'pricePerHour': pricePerHour,
      };
}
