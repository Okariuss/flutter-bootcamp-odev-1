import 'package:flutter/material.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/view/home/widgets/default_home_page_card_background.dart';
import 'package:food_app/ui/view/home/widgets/default_home_page_card_product_count_text_in_cart.dart';
import 'package:food_app/ui/view/home/widgets/default_home_page_card_product_price_text.dart';
import 'package:food_app/ui/view/home/widgets/default_home_page_card_product_title.dart';

class HomePageDefaultCard extends StatelessWidget {
  const HomePageDefaultCard({
    super.key,
    required this.deviceWidth,
    required this.product,
    required this.deviceHeight,
    required this.prefs,
  });

  final double deviceWidth;
  final Product product;
  final double deviceHeight;
  final PreferencesService prefs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: DefaultHomePageCardBackground(deviceWidth: deviceWidth),
        ),
        Positioned(
          top: 0,
          child: SizedBox(
            height: deviceWidth * 0.4,
            child: Image.network(
              product.imageUrl,
            ),
          ),
        ),
        Positioned(
          left: deviceWidth * 0.02,
          bottom: deviceHeight * 0.1,
          child: DefaultHomePageCardProductTitle(product: product),
        ),
        Positioned(
          left: deviceWidth * 0.02,
          bottom: deviceHeight * 0.02,
          child: DefaultHomePageCardProductPriceText(product: product),
        ),
        Positioned(
          right: deviceWidth * 0.02,
          bottom: deviceHeight * 0.01,
          child: DefaultHomePageCardProductCountTextInCart(
              product: product, prefs: prefs),
        ),
      ],
    );
  }
}
