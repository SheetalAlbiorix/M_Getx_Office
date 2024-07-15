class OfficeModel {
  final int? id;
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final int capacity;
  final String color;

  OfficeModel({
    this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.capacity,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'capacity': capacity,
      'color': color,
    };
  }

  static OfficeModel fromMap(Map<String, dynamic> map) {
    return OfficeModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      capacity: map['capacity'],
      color: map['color'],
    );
  }

  OfficeModel copyWith({
    int? id,
    String? name,
    String? address,
    String? email,
    String? phoneNumber,
    int? capacity,
    String? color,
  }) {
    return OfficeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      capacity: capacity ?? this.capacity,
      color: color ?? this.color,
    );
  }
}
