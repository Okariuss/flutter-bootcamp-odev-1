import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/cart_page_cubit.dart';

class DefaultHomePageCardProductCountTextInCart extends StatelessWidget {
  const DefaultHomePageCardProductCountTextInCart({
    super.key,
    required this.product,
    required this.prefs,
  });

  final Product product;
  final PreferencesService prefs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartPageCubit, List<CartProduct>>(
      builder: (context, cartProducts) {
        var cartProduct = cartProducts.firstWhere(
          (cartProduct) => cartProduct.productName == product.name,
          orElse: () => CartProduct(
              productName: product.name,
              productImageName: product.imageName,
              productPrice: product.price,
              username: prefs.username),
        );

        return CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: cartProduct.quantity > 0
                ? Text(
                    cartProduct.quantity.toString(),
                    style: const TextStyle(color: Colors.white),
                  )
                : const Icon(
                    Icons.add,
                    color: Colors.white,
                  ));
      },
    );
  }
}
