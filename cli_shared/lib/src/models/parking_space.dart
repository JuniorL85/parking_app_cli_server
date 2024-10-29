import 'package:objectbox/objectbox.dart';

@Entity()
class ParkingSpace {
  ParkingSpace({
    required this.address,
    required this.pricePerHour,
    required this.id,
  });

  @Id()
  int id;
  final String address;
  final int pricePerHour;

  ParkingSpace deserialize(Map<String, dynamic> json) =>
      ParkingSpace.fromJson(json);

  Map<String, dynamic> serialize(item) => toJson();

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