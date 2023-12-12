class Product {
  int id;
  String name;
  String imageName;
  String imageUrl;
  int price;
  bool? isFavorite;
  Product({
    required this.id,
    required this.name,
    required this.imageName,
    required this.imageUrl,
    required this.price,
    this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: int.parse(json['yemek_id']),
        name: json['yemek_adi'] as String,
        imageName: json['yemek_resim_adi'] as String,
        imageUrl: '',
        price: int.parse(json['yemek_fiyat']),
        isFavorite: false);
  }
}
