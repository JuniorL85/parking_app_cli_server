String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}

class ParkingSpace {
  ParkingSpace({
    required this.address,
    required this.pricePerHour,
    String? id,
  }) : id = id ?? idGenerator();

  final String id;
  final String address;
  final int pricePerHour;

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
