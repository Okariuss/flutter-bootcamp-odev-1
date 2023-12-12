import 'package:flutter/material.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';
import 'package:food_app/ui/cubit/cart_page_cubit.dart';
import 'package:food_app/ui/view/cart/widgets/change_quantity.dart';
import 'package:food_app/ui/view/cart/widgets/default_cart_background.dart';
import 'package:food_app/ui/view/cart/widgets/default_cart_price.dart';
import 'package:food_app/ui/view/cart/widgets/default_cart_product_title.dart';

class DefaultCart extends StatelessWidget {
  const DefaultCart({
    super.key,
    required this.deviceWidth,
    required this.product,
    required this.deviceHeight,
    required this.baseCubit,
    required this.productList,
  });

  final double deviceWidth;
  final CartProduct product;
  final double deviceHeight;
  final CartPageCubit baseCubit;
  final List<CartProduct> productList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 0,
          left: 80,
          right: 0,
          child: DefaultCartBackground(deviceWidth: deviceWidth),
        ),
        Positioned(
          left: -10,
          bottom: -20,
          top: -20,
          child: Image.network(
            product.productImageUrl!,
          ),
        ),
        Positioned(
          left: deviceWidth * 0.4,
          bottom: deviceHeight * 0.1,
          child: DefaultCartProductTitle(product: product),
        ),
        Positioned(
          left: deviceWidth * 0.4,
          bottom: deviceHeight * 0.02,
          child: DefaultCartPrice(product: product),
        ),
        Positioned(
          right: deviceWidth * 0.02,
          bottom: deviceHeight * 0.01,
          child: ChangeQuantity(
              product: product, baseCubit: baseCubit, productList: productList),
        ),
      ],
    );
  }
}
