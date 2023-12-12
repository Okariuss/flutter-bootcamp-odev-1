import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constants/app_strings.dart';
import 'package:food_app/core/constants/url_constants.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/repo/favorite_product_dao_repository.dart';
import 'package:food_app/data/repo/product_dao_repository.dart';
import 'package:food_app/data/utils/preference_service.dart';

class FavoritePageCubit extends Cubit<List<Product>> {
  FavoritePageCubit() : super(<Product>[]);

  final fRepo = FavoriteProductDaoRepository();
  final pRepo = ProductDaoRepository();
  final collectionFavorites =
      FirebaseFirestore.instance.collection(AppStrings.firestoreName);
  final prefs = PreferencesService();

  Future<String?> getDocumentId(String id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await collectionFavorites.where('id', isEqualTo: id).get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    } else {
      return null;
    }
  }

  Future<void> getFavorites(String userId) async {
    collectionFavorites
        .doc(await getDocumentId(userId))
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        var favorites = snapshot.data()?[AppStrings.favorites] as List<dynamic>;

        pRepo.getAllProducts().then((products) {
          var favoriteProducts = products
              .where((product) => favorites.contains(product.id.toString()))
              .toList();

          _updateProductImages(favoriteProducts);
          _updateFavorites(favoriteProducts);
          emit(List.of(favoriteProducts));
        }).catchError((e) {
          emit([]);
        });
      } else {
        emit([]);
      }
    });
  }

  Future<void> addFavorite(Product product) async {
    fRepo.addFavorite(product);
    await updateFavoriteInFirebase(product);
    emit(List.of(state));
  }

  Future<void> removeFavorite(Product product) async {
    fRepo.removeFavorite(product);
    await updateFavoriteInFirebase(product);
    emit(List.of(state));
  }

  Future<void> upgradeFavorites(
      List<Product> favoriteProducts, Product product) async {
    try {
      if (product.isFavorite!) {
        favoriteProducts.add(product);
      } else {
        favoriteProducts.removeWhere((p) => p.id == product.id);
      }

      emit(List.of(favoriteProducts));
    } catch (e) {}
  }

  Future<void> updateFavoriteInFirebase(Product product) async {
    try {
      final userId = prefs.userId;
      final userDocRef = collectionFavorites.doc(await getDocumentId(userId));
      final userData = await userDocRef.get();

      if (userData.exists) {
        final List<dynamic> favorites =
            userData.data()?[AppStrings.favorites] ?? [];

        final productId = product.id.toString();
        final index = favorites.indexOf(productId);

        if (product.isFavorite! && index == -1) {
          favorites.add(productId);
        } else if (!product.isFavorite! && index != -1) {
          favorites.removeAt(index);
        }

        await userDocRef.update({AppStrings.favorites: favorites});
      }
    } catch (e) {}
  }

  Future<void> _updateFavorites(List<Product> products) async {
    final userId = prefs.userId;
    final userDocId = await getDocumentId(userId);

    if (userDocId != null) {
      final snapshot = await collectionFavorites.doc(userDocId).get();
      if (snapshot.exists) {
        final List<dynamic> favorites =
            snapshot.data()?[AppStrings.favorites] ?? [];

        for (var product in products) {
          product.isFavorite = favorites.contains(product.id.toString());
        }
      }
    }

    emit(List.of(products));
  }

  void _updateProductImages(List<Product> products) {
    for (var product in products) {
      String imageUrl =
          '${UrlConstants.baseUrl}${UrlConstants.getImages}${product.imageName}';
      product.imageUrl = imageUrl;
    }
  }
}
