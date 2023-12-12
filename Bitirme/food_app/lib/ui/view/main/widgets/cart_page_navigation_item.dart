import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/ui/cubit/cart_page_cubit.dart';

class CartPageNavigationItem extends StatelessWidget {
  const CartPageNavigationItem({
    super.key,
    required this.d,
  });

  final AppLocalizations d;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: context.watch<CartPageCubit>().state.length > 0
          ? Badge(
              label:
                  Text(context.read<CartPageCubit>().state.length.toString()),
              child: Icon(Icons.shopping_cart),
            )
          : Icon(Icons.shopping_cart),
      label: d.cart,
    );
  }
}
