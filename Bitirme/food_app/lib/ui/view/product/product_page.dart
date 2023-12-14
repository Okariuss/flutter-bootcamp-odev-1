import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';
import 'package:food_app/data/entity/product/product.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/cart_page_cubit.dart';
import 'package:food_app/ui/cubit/favorite_page_cubit.dart';
import 'package:food_app/ui/cubit/home_page_cubit.dart';
import 'package:food_app/ui/view/product/widgets/default_recommended_product_icon.dart';
import 'package:food_app/ui/view/product/widgets/default_product_page_card_background.dart';
import 'package:food_app/ui/view/product/widgets/default_product_page_card_text.dart';
import 'package:food_app/ui/view/product/widgets/default_product_page_cart_price_text.dart';
import 'package:food_app/ui/view/product/widgets/default_recommended_product_price.dart';
import 'package:food_app/ui/view/product/widgets/default_recommended_product_text.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final prefs = PreferencesService();

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var deviceWidth = MediaQuery.sizeOf(context).width;
    var deviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: Text(d.app_name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.product.id,
              child: _defaultProductPageProduct(deviceWidth, deviceHeight, d),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _defaultProductPageCardChangeQuantity(d),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                d.similar_products,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            BlocBuilder<HomePageCubit, List<Product>>(
              builder: (context, productList) {
                List<Product> recommendedList = getRandomProducts(productList);

                return Padding(
                  padding: kTabLabelPadding,
                  child: GridView.builder(
                    itemCount: recommendedList.length,
                    shrinkWrap: true,
                    physics: PageScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 5,
                      crossAxisSpacing: deviceWidth * 0.05,
                    ),
                    itemBuilder: (context, index) {
                      var product = recommendedList[index];
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
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: DefaultProductPageCardBackground(
                                      deviceWidth: deviceWidth,
                                    )),
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
                                  child: DefaultRecommendedProductText(
                                      product: product),
                                ),
                                Positioned(
                                  left: deviceWidth * 0.02,
                                  bottom: deviceHeight * 0.02,
                                  child: DefaultRecommendedProductPrice(
                                      product: product, d: d),
                                ),
                                Positioned(
                                  right: deviceWidth * 0.02,
                                  bottom: deviceHeight * 0.01,
                                  child: DefaultRecommendedProductIcon(
                                      product: product, prefs: prefs),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _defaultProductPageProduct(
      double deviceWidth, double deviceHeight, AppLocalizations d) {
    return SizedBox(
      height: deviceWidth * 0.8,
      width: deviceWidth * 0.8,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DefaultProductPageCardBackground(deviceWidth: deviceWidth),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              height: deviceWidth * 0.6,
              child: Image.network(
                widget.product.imageUrl,
              ),
            ),
          ),
          Positioned(
            left: deviceWidth * 0.02,
            bottom: deviceHeight * 0.1,
            child: DefaultProductPageCardText(widget: widget),
          ),
          Positioned(
            left: deviceWidth * 0.02,
            bottom: deviceHeight * 0.02,
            child: DefaultProductPageCartPriceText(widget: widget, d: d),
          ),
          Positioned(
            right: deviceWidth * 0.02,
            bottom: deviceHeight * 0.01,
            child: _defaultProductPageCardIsFavorite(),
          ),
        ],
      ),
    );
  }

  BlocBuilder<CartPageCubit, List<CartProduct>>
      _defaultProductPageCardChangeQuantity(AppLocalizations d) {
    return BlocBuilder<CartPageCubit, List<CartProduct>>(
      builder: (context, cartProducts) {
        var cartProduct = cartProducts.firstWhere(
          (cartProduct) => cartProduct.productName == widget.product.name,
          orElse: () {
            var productInCart = CartProduct(
              productName: widget.product.name,
              productImageName: widget.product.imageName,
              productPrice: widget.product.price,
              username: prefs.username,
            );
            return productInCart;
          },
        );

        return cartProduct.quantity > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (cartProduct.quantity > 0) {
                        context
                            .read<CartPageCubit>()
                            .decreaseProductQuantity(cartProduct);
                        _upgradeCart(context, cartProducts, cartProduct);
                      }
                    },
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      cartProduct.quantity.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      context
                          .read<CartPageCubit>()
                          .increaseProductQuantity(cartProduct);
                      _upgradeCart(context, cartProducts, cartProduct);
                    },
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: () {
                  context
                      .read<CartPageCubit>()
                      .increaseProductQuantity(cartProduct);
                  _upgradeCart(context, cartProducts, cartProduct);
                },
                child: Text(d.add_to_cart),
              );
      },
    );
  }

  BlocBuilder<FavoritePageCubit, List<Product>>
      _defaultProductPageCardIsFavorite() {
    return BlocBuilder<FavoritePageCubit, List<Product>>(
      builder: (context, favoriteList) {
        var product = favoriteList.firstWhere(
          (product) => product.name == widget.product.name,
          orElse: () {
            var product = Product(
              id: widget.product.id,
              name: widget.product.name,
              imageName: widget.product.imageName,
              price: widget.product.price,
              imageUrl: '',
              isFavorite: widget.product.isFavorite,
            );

            return product;
          },
        );

        return IconButton(
          onPressed: () {
            if (product.isFavorite!) {
              context.read<FavoritePageCubit>().removeFavorite(product);
            } else {
              context.read<FavoritePageCubit>().addFavorite(product);
            }
            _upgradeFavorites(context, favoriteList, product);
          },
          icon: product.isFavorite!
              ? const Icon(
                  Icons.favorite,
                  color: AppColors.primaryColor,
                )
              : const Icon(Icons.favorite_border),
        );
      },
    );
  }

  List<Product> getRandomProducts(List<Product> productList) {
    var recommendedList = <Product>[];

    // Shuffle the indices of the productList
    var indices = List.generate(productList.length, (index) => index);
    indices.shuffle();

    var index = 0;
    while (recommendedList.length < 6 && index < productList.length) {
      var randomIndex = indices[index];
      var randomProduct = productList[randomIndex];

      if (randomProduct.name != widget.product.name) {
        recommendedList.add(randomProduct);
      }

      index++;
    }

    return recommendedList;
  }

  void _upgradeCart(BuildContext context, List<CartProduct> cartProducts,
      CartProduct cartProduct) {
    context.read<CartPageCubit>().upgradeCart(cartProducts, cartProduct);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLoadingDialog(context);
    });
  }

  void _upgradeFavorites(
      BuildContext context, List<Product> favoriteProducts, Product product) {
    context
        .read<FavoritePageCubit>()
        .upgradeFavorites(favoriteProducts, product);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLoadingDialog(context);
    });
  }

  void _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    await Future.delayed(const Duration(milliseconds: 150));

    Navigator.of(context).pop();
  }
}
