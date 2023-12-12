import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/favorite_page_cubit.dart';
import 'package:food_app/ui/view/favorites/widgets/default_favorite_card_background.dart';
import 'package:food_app/ui/view/favorites/widgets/default_favorite_card_favorite_button.dart';
import 'package:food_app/ui/view/favorites/widgets/default_favorite_card_product_name.dart';
import 'package:food_app/ui/view/favorites/widgets/default_favorite_card_product_price.dart';
import 'package:food_app/ui/view/favorites/widgets/empty_favorite.dart';
import 'package:food_app/ui/view/product/product_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prefs = PreferencesService();
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<FavoritePageCubit, List<Product>>(
      builder: (context, productList) {
        if (productList.isEmpty) {
          return const EmptyFavorite();
        }

        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: GridView.builder(
            itemCount: productList.length,
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 1,
              mainAxisSpacing: deviceWidth * 0.1,
            ),
            itemBuilder: (context, index) {
              final product = productList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductPage(
                          product: product,
                        );
                      },
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.centerLeft,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 80,
                      right: 0,
                      child: DefaultFavoriteCardBackground(
                          deviceWidth: deviceWidth),
                    ),
                    Positioned(
                      left: -10,
                      bottom: -20,
                      top: -20,
                      child: Image.network(
                        product.imageUrl,
                      ),
                    ),
                    Positioned(
                      left: deviceWidth * 0.4,
                      bottom: deviceHeight * 0.1,
                      child: DefaultFavoriteCardProductName(product: product),
                    ),
                    Positioned(
                      left: deviceWidth * 0.4,
                      bottom: deviceHeight * 0.02,
                      child: DefaultFavoriteCardProductPrice(product: product),
                    ),
                    Positioned(
                      right: deviceWidth * 0.02,
                      bottom: deviceHeight * 0.01,
                      child: DefaultFavoriteCardFavoriteButton(
                          product: product, prefs: prefs),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
