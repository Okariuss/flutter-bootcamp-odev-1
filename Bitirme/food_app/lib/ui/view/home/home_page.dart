import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/cart_page_cubit.dart';
import 'package:food_app/ui/cubit/favorite_page_cubit.dart';
import 'package:food_app/ui/cubit/home_page_cubit.dart';
import 'package:food_app/ui/view/home/widgets/home_page_default_card.dart';
import 'package:food_app/ui/view/home/widgets/product_not_found.dart';
import 'package:food_app/ui/view/product/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = PreferencesService();
  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().getAllProducts();
    context.read<CartPageCubit>().getProducts(prefs.username);
    context.read<FavoritePageCubit>().getFavorites(prefs.userId);
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.sizeOf(context).width;
    var deviceHeight = MediaQuery.sizeOf(context).height;

    return BlocBuilder<HomePageCubit, List<Product>>(
      builder: (context, productList) {
        if (productList.isNotEmpty) {
          return Padding(
            padding: kTabLabelPadding,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _calculateCrossAxisCount(deviceWidth),
                childAspectRatio: 3 / 5,
                crossAxisSpacing: deviceWidth * 0.05,
                mainAxisSpacing: deviceHeight * 0.03,
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                var product = productList[index];
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Hero(
                      tag: product.id,
                      child: HomePageDefaultCard(
                          deviceWidth: deviceWidth,
                          product: product,
                          deviceHeight: deviceHeight,
                          prefs: prefs),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (productList.isEmpty) {
          return const ProductNotFound();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  int _calculateCrossAxisCount(double width) {
    int crossAxisCount = (width / 150).floor();

    return crossAxisCount > 1 ? crossAxisCount : 1;
  }
}
