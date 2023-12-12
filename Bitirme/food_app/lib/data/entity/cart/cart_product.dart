class CartProduct {
  int? cartProductId;
  String? productName;
  String? productImageName;
  String? productImageUrl;
  int? productPrice;
  int quantity;
  String username;
  CartProduct(
      {this.cartProductId,
      this.productName,
      this.productImageName,
      this.productImageUrl,
      this.productPrice,
      this.quantity = 0,
      required this.username});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      cartProductId: int.parse(json['sepet_yemek_id']),
      productName: json['yemek_adi'] as String,
      productImageName: json['yemek_resim_adi'] as String,
      productImageUrl: '',
      productPrice: int.parse(json['yemek_fiyat']),
      quantity: int.parse(json['yemek_siparis_adet']),
      username: json['kullanici_adi'] as String,
    );
  }
}
