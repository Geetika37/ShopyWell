class UserModel {
  final String uid;
  final String email;
  final DateTime? createdAt;

  UserModel({required this.uid, required this.email, this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',

      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,

      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
