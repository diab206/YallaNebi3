class UserDataModel {
  String email, name, userId;
  // Optional ID field if needed

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
}
