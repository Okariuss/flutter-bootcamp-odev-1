import 'package:food_app/data/entity/product/product.dart';

class FavoriteProductDaoRepository {
  Future<Product> addFavorite(Product product) async {
    product.isFavorite = true;
    return product;
  }

  Future<Product> removeFavorite(Product product) async {
    product.isFavorite = false;
    return product;
  }
}
