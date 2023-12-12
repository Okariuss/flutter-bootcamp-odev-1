import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_app/core/constants/url_constants.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';
import 'package:food_app/data/entity/cart/cart_product_response.dart';

class CartProductDaoRepository {
  List<CartProduct> parseCartResponse(String response) {
    try {
      return CartProductResponse.fromJson(jsonDecode(response)).carts;
    } catch (e) {
      return <CartProduct>[];
    }
  }

  Future<List<CartProduct>> getProductsOnCart(String name) async {
    var url = "${UrlConstants.baseUrl}${UrlConstants.productsOnCart}";
    var changedUsername = name.toLowerCase().replaceAll(" ", "_");
    var data = {"kullanici_adi": changedUsername};
    var response = await Dio().post(url, data: FormData.fromMap(data));
    return parseCartResponse(response.data.toString());
  }

  Future<void> deleteProduct(int id, String username) async {
    var url = "${UrlConstants.baseUrl}${UrlConstants.deleteProductFromCart}";
    var changedUsername = username.toLowerCase().replaceAll(" ", "_");
    var data = {
      "sepet_yemek_id": id.toString(),
      "kullanici_adi": changedUsername,
    };
    await Dio().post(url, data: FormData.fromMap(data));
  }

  Future<void> addProductToCart(String productName, String productImageName,
      int productPrice, int quantity, String username) async {
    var url = "${UrlConstants.baseUrl}${UrlConstants.addProductToCart}";
    var changedUsername = username.toLowerCase().replaceAll(" ", "_");
    var data = {
      "yemek_adi": productName,
      "yemek_resim_adi": productImageName,
      "yemek_fiyat": productPrice.toString(),
      "yemek_siparis_adet": quantity.toString(),
      "kullanici_adi": changedUsername,
    };
    await Dio().post(url, data: FormData.fromMap(data));
  }

  Future<void> updateProductToCart(
      int id,
      String productName,
      String productImageName,
      int productPrice,
      int quantity,
      String username) async {
    var url = "${UrlConstants.baseUrl}${UrlConstants.addProductToCart}";
    var changedUsername = username.toLowerCase().replaceAll(" ", "_");

    var data = {
      "sepet_yemek_id": id.toString(),
      "yemek_adi": productName,
      "yemek_resim_adi": productImageName,
      "yemek_fiyat": productPrice.toString(),
      "yemek_siparis_adet": quantity.toString(),
      "kullanici_adi": changedUsername,
    };
    await Dio().post(url, data: FormData.fromMap(data));
  }

  Future<CartProduct> increaseProductQuantity(CartProduct product) async {
    product.quantity++;
    return product;
  }

  Future<CartProduct> decreaseProductQuantity(CartProduct product) async {
    product.quantity--;
    return product;
  }
}
