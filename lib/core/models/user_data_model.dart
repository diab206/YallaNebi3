class UserDataModel {
  String email, name, userId;

  UserDataModel({
    required this.userId,
    required this.email,
    required this.name,
  });
  
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name};
  }

  // Add this copyWith method
  UserDataModel copyWith({
    String? userId,
    String? name,
    String? email,
  }) {
    return UserDataModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}