import 'package:food_app/data/entity/product/product.dart';

class ProductResponse {
  List<Product> products;
  int success;

  ProductResponse({
    required this.products,
    required this.success,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    int success = json['success'];
    var jsonArray = json['yemekler'] as List;
    List<Product> products = jsonArray
        .map((jsonArrayObject) => Product.fromJson(jsonArrayObject))
        .toList();
    return ProductResponse(success: success, products: products);
  }
}
