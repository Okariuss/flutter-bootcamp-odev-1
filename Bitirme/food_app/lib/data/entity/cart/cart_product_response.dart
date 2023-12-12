import 'package:food_app/data/entity/cart/cart_product.dart';

class CartProductResponse {
  List<CartProduct> carts;
  int success;
  CartProductResponse({
    required this.carts,
    required this.success,
  });
  factory CartProductResponse.fromJson(Map<String, dynamic> json) {
    int success = json['success'];
    var jsonArray = json['sepet_yemekler'] as List;
    List<CartProduct> carts = jsonArray
        .map((jsonArrayObject) => CartProduct.fromJson(jsonArrayObject))
        .toList();
    return CartProductResponse(carts: carts, success: success);
  }
}
