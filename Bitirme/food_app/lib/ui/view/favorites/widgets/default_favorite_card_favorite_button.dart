import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/favorite_page_cubit.dart';

class DefaultFavoriteCardFavoriteButton extends StatelessWidget {
  const DefaultFavoriteCardFavoriteButton({
    super.key,
    required this.product,
    required this.prefs,
  });

  final Product product;
  final PreferencesService prefs;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        product.isFavorite! ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        if (product.isFavorite!) {
          context.read<FavoritePageCubit>().removeFavorite(product);
        } else {
          context.read<FavoritePageCubit>().addFavorite(product);
        }
        context.read<FavoritePageCubit>().getFavorites(prefs.userId);
      },
    );
  }
}
