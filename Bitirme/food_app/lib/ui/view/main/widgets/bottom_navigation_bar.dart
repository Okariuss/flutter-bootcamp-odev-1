import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/ui/cubit/main_page_cubit.dart';
import 'package:food_app/ui/view/main/widgets/cart_page_navigation_item.dart';
import 'package:food_app/ui/view/main/widgets/favorites_page_navigation_item.dart';
import 'package:food_app/ui/view/main/widgets/home_page_navigation_item.dart';

class MainPageBottomNavigationBar extends StatelessWidget {
  const MainPageBottomNavigationBar({
    super.key,
    required this.d,
    required this.selectedIndex,
  });

  final AppLocalizations d;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) {
        context.read<MainPageCubit>().changePage(value);
      },
      destinations: [
        HomePageNavigationItem(d: d),
        FavoritesPageNavigationItem(d: d),
        CartPageNavigationItem(d: d),
      ],
    );
  }
}
