// ignore_for_file: non_constant_identifier_names

class AddBikeModel {
  final String type;
  final String user_id;
  final String price_per_day;
  final String image_url;
  final String condition;

  AddBikeModel({
    required this.type,
    required this.user_id,
    required this.price_per_day,
    required this.image_url,
    required this.condition,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'type': type,
      'price_per_day': price_per_day,
      'image_url': image_url,
      'condition': condition,
    };
  }

  factory AddBikeModel.fromMap(Map<String, dynamic> map) {
    return AddBikeModel(
      type: map['type'] ?? '',
      user_id: map['user_id'] ?? '',
      price_per_day: map['price_per_day'] ?? '',
      image_url: map['image_url'] ?? '',
      condition: map['condition'] ?? '',
    );
  }
}
