import 'package:flutter/foundation.dart';
import 'package:project/models/cart_model.dart';
import 'package:project/models/product_model.dart';
import 'package:project/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  void addProductToCart({required String productId}) {
    //beh awel 7aja st3mlna el map khater key value t3wna
    //fiha yaser methodes predefined kima el methode
    //putIfAbsent hathi ken mt9ahch atzid m8ir tksir karyem
    _cartItems.putIfAbsent(
        productId,
        () => CartModel(
            cartId: const Uuid().v4(), //auto generated le id t3tik randomized
            productId: productId,
            quantity: 1)); // abdina men 1 bach el user
    notifyListeners(); //bach t3mel update w7dha
  }

  void updateQuantity({required String productId, required int quantity}) {
    _cartItems.update(
        productId,
        (item) => CartModel(
            cartId: item.cartId, //auto generated le id t3tik randomized
            productId: productId,
            quantity: quantity)); // abdina men 1 bach el user
    notifyListeners(); //bach t3mel update w7dha
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;
    _cartItems.forEach((key, value) {
      final ProductModel? getCurrProduct =
          productProvider.findByProdId(value.productId);
      if (getCurrProduct == null) {
        total += 0;
      } else {
        total += double.parse(getCurrProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  int getQty() {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total; // atjiblek el total mta3 el quantity mta3 el product
                  // mtnst79ouch bach n3mlou notifyListeners(); khater manich bach n3mel 
                  //modfiy bach recupire

  }

  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
