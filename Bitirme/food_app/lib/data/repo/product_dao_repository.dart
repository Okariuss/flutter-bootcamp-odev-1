import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_app/core/constants/url_constants.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/entity/product/product_response.dart';

class ProductDaoRepository {
  List<Product> parseProductResponse(String response) {
    try {
      return ProductResponse.fromJson(jsonDecode(response)).products;
    } catch (e) {
      return <Product>[];
    }
  }

  Future<List<Product>> getAllProducts() async {
    var url = "${UrlConstants.baseUrl}${UrlConstants.allProducts}";
    var response = await Dio().get(url);
    return parseProductResponse(response.data.toString());
  }
}
