import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constants/app_strings.dart';
import 'package:food_app/core/constants/url_constants.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/repo/product_dao_repository.dart';
import 'package:food_app/data/utils/preference_service.dart';

class HomePageCubit extends Cubit<List<Product>> {
  HomePageCubit() : super(<Product>[]);

  var pRepo = ProductDaoRepository();
  var collectionFavorites =
      FirebaseFirestore.instance.collection(AppStrings.firestoreName);
  var prefs = PreferencesService();

  String _currentSearchWord = '';

  Future<String?> getDocumentId(String id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await collectionFavorites.where('id', isEqualTo: id).get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    } else {
      return null;
    }
  }

  Future<void> getAllProducts() async {
    List<Product> products = await pRepo.getAllProducts();
    _updateProductImages(products);
    _updateFavorites(products);
    _currentSearchWord = '';
    emit(products);
  }

  Future<void> searchProduct(String word) async {
    _currentSearchWord = word.toLowerCase();
    List<Product> products = await pRepo.getAllProducts();
    _applyFilters(products);
  }

  void sortProductsByNameAndPrice(bool sortByName, bool sortByPrice) {
    state.sort((a, b) {
      if (sortByName && sortByPrice) {
        final nameComparison =
            a.name.toLowerCase().compareTo(b.name.toLowerCase());
        if (nameComparison != 0) {
          return nameComparison;
        } else {
          return a.price.compareTo(b.price);
        }
      } else if (sortByName) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else if (sortByPrice) {
        return a.price.compareTo(b.price);
      }
      return 1;
    });

    _applyFilters(state);
  }

  void _applyFilters(List<Product> products) {
    List<Product> filteredProducts = products.where((product) {
      final productName = product.name.toLowerCase();
      return productName.contains(_currentSearchWord);
    }).toList();
    _updateProductImages(filteredProducts);
    emit(filteredProducts);
  }

  void _updateProductImages(List<Product> products) {
    for (var product in products) {
      String imageUrl =
          '${UrlConstants.baseUrl}${UrlConstants.getImages}${product.imageName}';
      product.imageUrl = imageUrl;
    }
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
}
