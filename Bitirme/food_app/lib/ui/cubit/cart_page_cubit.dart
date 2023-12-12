import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constants/url_constants.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';
import 'package:food_app/data/repo/cart_product_dao_repository.dart';

class CartPageCubit extends Cubit<List<CartProduct>> {
  CartPageCubit() : super(<CartProduct>[]);

  var cRepo = CartProductDaoRepository();

  Future<void> getProducts(String username) async {
    List<CartProduct> products = await cRepo.getProductsOnCart(username);
    for (var product in products) {
      String imageUrl =
          '${UrlConstants.baseUrl}${UrlConstants.getImages}${product.productImageName}';
      product.productImageUrl = imageUrl;
    }
    emit(products);
  }

  Future<void> deleteProduct(String username, int id) async {
    await cRepo.deleteProduct(id, username);
    getProducts(username);
  }

  Future<void> addProduct(String productName, String productImageName,
      int productPrice, int quantity, String username) async {
    await cRepo.addProductToCart(
        productName, productImageName, productPrice, quantity, username);
    getProducts(username);
  }

  Future<void> updateProductQuantity(
      int id,
      String productName,
      String productImageName,
      int productPrice,
      int quantity,
      String username) async {
    await cRepo.deleteProduct(id, username);
    await cRepo.updateProductToCart(
        id, productName, productImageName, productPrice, quantity, username);
  }

  Future<void> increaseProductQuantity(CartProduct product) async {
    cRepo.increaseProductQuantity(product);
    emit(List.of(state));
  }

  Future<void> decreaseProductQuantity(CartProduct product) async {
    cRepo.decreaseProductQuantity(product);
    emit(List.of(state));
  }

  Future<void> clearCart() async {
    for (var product in state) {
      await deleteProduct(product.username, product.cartProductId!);
    }
    emit(List.of(state));
  }

  Future<void> upgradeCart(
      List<CartProduct> cartProducts, CartProduct productInCart) async {
    if (!cartProducts.contains(productInCart)) {
      await addProduct(
          productInCart.productName!,
          productInCart.productImageName!,
          productInCart.productPrice!,
          productInCart.quantity,
          productInCart.username);
    } else {
      if (productInCart.quantity == 0) {
        await deleteProduct(
          productInCart.username,
          productInCart.cartProductId!,
        );
      } else {
        await updateProductQuantity(
          productInCart.cartProductId!,
          productInCart.productName!,
          productInCart.productImageName!,
          productInCart.productPrice!,
          productInCart.quantity,
          productInCart.username,
        );
      }
    }
    getProducts(productInCart.username);
  }
}
