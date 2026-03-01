// ignore_for_file: non_constant_identifier_names

class AddCarModel {
  final String brand;
  final String descripttion;
  final String price_per_day;
  final String image_url;
  final String model;
  final String year;
  final String transmission;
  final String user_id;

  AddCarModel({
    required this.brand,
    required this.descripttion,
    required this.price_per_day,
    required this.image_url,
    required this.model,
    required this.year,
    required this.transmission,
    required this.user_id,
  });
  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'brand': brand,
      'descripttion': descripttion,
      'price_per_day': price_per_day,
      'image_url': image_url,
      'model': model,
      'year': year,
      'transmission': transmission,
    };
  }

  factory AddCarModel.fromMap(Map<String, dynamic> map) {
    return AddCarModel(
      brand: map['brand'],
      descripttion: map['descripttion'],
      price_per_day: map['price_per_day'],
      image_url: map['image_url'],
      model: map['model'],
      year: map['year'],
      transmission: map['transmission'],
      user_id: map['user_id'],
    );
  }
}
