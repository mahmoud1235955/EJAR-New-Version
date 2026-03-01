class AddPropirityModel {
  final String title;
  final String location;
  final String price_per_month;
  final String img_url;
  final String description;
  final String user_id;
  AddPropirityModel({
    required this.title,
    required this.location,
    required this.price_per_month,
    required this.img_url,
    required this.description,
    required this.user_id,
  });
  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'title': title,
      'location': location,
      'price_per_month': price_per_month,
      'img_url': img_url,
      'description': description,
    };
  }

  factory AddPropirityModel.fromMap(Map<String, dynamic> map) {
    return AddPropirityModel(
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      price_per_month: map['price_per_month'] ?? '',
      img_url: map['img_url'] ?? '',
      description: map['description'] ?? '',
      user_id: map['user_id'] ?? '',
    );
  }
}
