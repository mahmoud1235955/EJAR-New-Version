class ReciveProfileModel {
  final String full_name;
  final String phone;
  final String bio;
  final String email;
  ReciveProfileModel({
    required this.full_name,
    required this.phone,
    required this.bio,
    required this.email,
  });

  factory ReciveProfileModel.fromJson(Map<String, dynamic> json) =>
      ReciveProfileModel(
        full_name: json['full_name'],
        phone: json['phone'],
        bio: json['bio'],
        email: json['email'],
      );
}
