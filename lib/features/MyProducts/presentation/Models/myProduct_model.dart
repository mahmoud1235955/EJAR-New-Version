class MyproductModel {
  final String image;
  final String title;
  final String price;

  MyproductModel({
    required this.image,
    required this.title,
    required this.price,
  });
  factory MyproductModel.fromJson(Map<String, dynamic> json) {
    return MyproductModel(
      image: json['image'],
      title: json['title'],
      price: json['price'],
    );
  }
}
