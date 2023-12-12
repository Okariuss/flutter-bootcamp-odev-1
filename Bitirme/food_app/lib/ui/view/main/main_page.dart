import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/core/constants/app_images.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/home_page_cubit.dart';
import 'package:food_app/ui/cubit/main_page_cubit.dart';
import 'package:food_app/ui/view/cart/cart_page.dart';
import 'package:food_app/ui/view/favorites/favorites_page.dart';
import 'package:food_app/ui/view/home/home_page.dart';
import 'package:food_app/ui/view/main/widgets/bottom_navigation_bar.dart';
import 'package:food_app/ui/view/main/widgets/cart_app_bar.dart';
import 'package:food_app/ui/view/main/widgets/favorites_app_bar.dart';
import 'package:food_app/ui/view/main/widgets/home_page_app_bar.dart';
import 'package:food_app/ui/view/main/widgets/main_page_avatar_icon.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isSearch = false;
  bool isFiltered = false;
  bool isNameChecked = true;
  bool isPriceChecked = false;
  var searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var pages = [
    const HomePage(),
    const FavoritesPage(),
    const CartPage(),
  ];
  final prefs = PreferencesService();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var deviceHeight = MediaQuery.sizeOf(context).height;
    var appBarWidgets = [
      HomePageAppBar(prefs: prefs, d: d),
      FavoritesAppBar(d: d),
      CartAppBar(d: d),
    ];

    return BlocBuilder<MainPageCubit, int>(
      builder: (context, selectedIndex) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            setState(() {
              isSearch = false;
            });
          },
          child: Scaffold(
            backgroundColor: AppColors.appBackground,
            appBar: AppBar(
              title: appBarWidgets[selectedIndex],
              bottom: selectedIndex == 0
                  ? _bottomAppBar(deviceHeight, context, d)
                  : null,
              actions: [
                MainPageAvatarIcon(prefs: prefs),
              ],
            ),
            body: pages[selectedIndex],
            bottomNavigationBar:
                MainPageBottomNavigationBar(d: d, selectedIndex: selectedIndex),
          ),
        );
      },
    );
  }

  PreferredSize _bottomAppBar(
      double deviceHeight, BuildContext context, AppLocalizations d) {
    return PreferredSize(
      preferredSize: Size.fromHeight(deviceHeight / 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: _bottomAppBarSearchBar(context, d),
                    ),
                  ),
                  _defaultPopUpMenuButton(context, d),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _bottomAppBarSearchBar(
      BuildContext context, AppLocalizations d) {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: d.search_food,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            setState(() {
              isSearch = false;
            });
            searchController.clear();
            context.read<HomePageCubit>().getAllProducts();
          },
          icon: isSearch ? const Icon(Icons.close) : const Icon(Icons.search),
        ),
      ),
      onTap: () {
        setState(() {
          isSearch = true;
        });
      },
      onChanged: (value) {
        setState(() {
          isSearch = value.isNotEmpty;
        });
        context.read<HomePageCubit>().searchProduct(value);
      },
    );
  }

  PopupMenuButton<String> _defaultPopUpMenuButton(
      BuildContext context, AppLocalizations d) {
    return PopupMenuButton<String>(
      icon: Stack(
        children: [
          Image.asset(
            AppImages.rectangleIcon,
            scale: 1.2,
          ),
          const Positioned.fill(
            child: Center(
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      onSelected: (String value) {
        setState(() {
          if (value == d.name_text) {
            isNameChecked = !isNameChecked;
          } else if (value == d.price_text) {
            isPriceChecked = !isPriceChecked;
          }
          // Update the sorting logic based on the toggled values
          context
              .read<HomePageCubit>()
              .sortProductsByNameAndPrice(isNameChecked, isPriceChecked);
        });
      },
      itemBuilder: (BuildContext context) =>
          _buildPopupItems(d, isNameChecked, isPriceChecked),
    );
  }

  List<PopupMenuEntry<String>> _buildPopupItems(
      AppLocalizations d, bool isNameChecked, bool isPriceChecked) {
    return [
      _buildPopupMenuItem(d.name_text, isNameChecked ? d.asc : d.desc,
          d.name_text, isNameChecked),
      _buildPopupMenuItem(d.price_text, isPriceChecked ? d.asc : d.desc,
          d.price_text, isPriceChecked),
      // Add more items if needed based on your data model
    ];
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String value, String ascDescText, String displayText, bool isChecked) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Text(
            ascDescText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isChecked ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(width: 8),
          Text(displayText),
        ],
      ),
    );
  }
}
