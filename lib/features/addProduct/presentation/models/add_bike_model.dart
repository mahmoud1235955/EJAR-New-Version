// ignore_for_file: non_constant_identifier_names

class AddBikeModel {
  final String name;
  final String user_id;
  final String price_per_day;
  final String image_url;
  final String location;
  final String descripttion;
  final String id;

  AddBikeModel({
    required this.name,
    required this.user_id,
    required this.price_per_day,
    required this.image_url,
    required this.descripttion,
    required this.location,
    this.id = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'name': name,
      'price_per_day': price_per_day,
      'image_url': image_url,
      'location': location,
      'descripttion': descripttion,
    };
  }

  factory AddBikeModel.fromMap(Map<String, dynamic> map) {
    return AddBikeModel(
      name: map['name'] ?? '',
      user_id: map['user_id'] ?? '',
      price_per_day: map['price_per_day'].toString(),
      image_url: map['image_url'] ?? '',
      location: map['location'] ?? '',
      descripttion: map['descripttion'] ?? '',
      id: map['id'].toString(),
    );
  }
}
