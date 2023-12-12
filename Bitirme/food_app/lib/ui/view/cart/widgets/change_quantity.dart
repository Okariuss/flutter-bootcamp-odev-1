import 'package:flutter/material.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';
import 'package:food_app/ui/cubit/cart_page_cubit.dart';

class ChangeQuantity extends StatelessWidget {
  const ChangeQuantity({
    super.key,
    required this.product,
    required this.baseCubit,
    required this.productList,
  });

  final CartProduct product;
  final CartPageCubit baseCubit;
  final List<CartProduct> productList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () async {
            if (product.quantity > 0) {
              await baseCubit.decreaseProductQuantity(product);
              await baseCubit.upgradeCart(productList, product);
            }
          },
        ),
        Text(product.quantity.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            await baseCubit.increaseProductQuantity(product);
            await baseCubit.upgradeCart(productList, product);
          },
        ),
      ],
    );
  }
}
