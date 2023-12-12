import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';
import 'package:food_app/ui/cubit/cart_page_cubit.dart';
import 'package:food_app/ui/view/cart/widgets/default_cart.dart';
import 'package:food_app/ui/view/cart/widgets/empty_cart_widget.dart';
import 'package:food_app/ui/view/cart/widgets/delete_container.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var baseCubit = context.read<CartPageCubit>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CartPageCubit, List<CartProduct>>(
        builder: (context, productList) {
          if (productList.isEmpty) {
            return const EmptyCartWidget();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showLoadingDialog(context);
            });

            return Column(
              children: [
                Expanded(child: _buildCartList(productList, baseCubit)),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "${_calculateTotalPrice(productList, d)} ${d.price}",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                      const Divider(
                        color: AppColors.primaryColor,
                        thickness: 2,
                        indent: 16,
                        endIndent: 16,
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _paymentCompleted(productList, context, d);
                        },
                        child: Text(d.pay),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCartList(
      List<CartProduct> productList, CartPageCubit baseCubit) {
    var deviceWidth = MediaQuery.sizeOf(context).width;
    var deviceHeight = MediaQuery.sizeOf(context).height;
    return GridView.builder(
      itemCount: productList.length,
      shrinkWrap: true,
      physics: const PageScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 1,
        mainAxisSpacing: deviceWidth * 0.1,
      ),
      itemBuilder: (context, index) {
        var product = productList[index];
        return Dismissible(
          key: Key(product.cartProductId.toString()),
          direction: DismissDirection.endToStart,
          background: const DeleteContainer(),
          onDismissed: (direction) async {
            await baseCubit.deleteProduct(
                product.username, product.cartProductId!);
          },
          child: DefaultCart(
              deviceWidth: deviceWidth,
              product: product,
              deviceHeight: deviceHeight,
              baseCubit: baseCubit,
              productList: productList),
        );
      },
    );
  }

  double _calculateTotalPrice(
      List<CartProduct> productList, AppLocalizations d) {
    double totalPrice = 0.0;
    for (var product in productList) {
      totalPrice += product.productPrice! * product.quantity;
    }
    return d.price == "₺"
        ? totalPrice
        : double.parse((totalPrice / 30).toStringAsFixed(2));
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

void _paymentCompleted(
    List<CartProduct> productList, BuildContext context, AppLocalizations d) {
  context.read<CartPageCubit>().clearCart();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(d.payment_completed),
      duration: const Duration(seconds: 2),
    ),
  );
}
