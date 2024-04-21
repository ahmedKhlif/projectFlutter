import 'package:flutter/material.dart';
import 'package:project/providers/cart_provider.dart';
import 'package:project/screens/cart/bottom_checkout.dart';
import 'package:project/screens/cart/cart_widget.dart';
import 'package:project/services/assets_manager.dart';
import 'package:project/services/my_app_method.dart';
import 'package:project/widgets/empty_bag.dart';
import 'package:project/widgets/title_text.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context); 
    return  cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your cart is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomCheckout(),
            appBar: AppBar(
              title:  TitlesTextWidget(label: "Cart (${cartProvider.getCartItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                      MyAppMethods.showErrorORWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Remove items",
                        fct: () {
                          cartProvider.clearLocalCart();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (context, index) {
                      return  ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values.toList().reversed.toList()[index], //khater 7chit ena bel les valueurs jbnahou bel .values wradinahoum list
                            child: const CartWidget() ,   //bach yo9leb el list bach akher 7aja atzidha tarha lawla 
                      );
                    },
                  ),
                ),
                const SizedBox(height:kBottomNavigationBarHeight +10),
              ],
            ),
          );
  }
}
