class StaffModel {
  final int? id;
  final String? name;
  final String? lastName;
  final String avtar;
  final int officeId;


  StaffModel({
    this.id,
    required this.avtar,
    required this.name,
    required this.lastName,
    required this.officeId,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'avtar': avtar,
      'officeId': officeId,
    };
  }

  static StaffModel fromMap(Map<String, dynamic> map) {
    return StaffModel(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      avtar: map['avtar'],
      officeId: map['officeId'],
    );
  }

  StaffModel copyWith({
    int? id,
    String? name,
    String? lastName,
    String? avtar,
    int? officeId,
  }) {
    return StaffModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      avtar: avtar ?? this.avtar,
      officeId: officeId ?? this.officeId,
    );
  }
}