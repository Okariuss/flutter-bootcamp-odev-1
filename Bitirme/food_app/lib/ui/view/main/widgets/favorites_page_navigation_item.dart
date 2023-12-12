import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/ui/cubit/favorite_page_cubit.dart';

class FavoritesPageNavigationItem extends StatelessWidget {
  const FavoritesPageNavigationItem({
    super.key,
    required this.d,
  });

  final AppLocalizations d;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: context.watch<FavoritePageCubit>().state.length > 0
          ? Badge(
              label: Text(
                  context.read<FavoritePageCubit>().state.length.toString()),
              child: Icon(Icons.favorite),
            )
          : Icon(Icons.favorite),
      label: d.favorites,
    );
  }
}
