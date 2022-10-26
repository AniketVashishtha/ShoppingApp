import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: empty_constructor_bodies
class CartItem {
  final String id;
  final String productName;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.price,
      required this.productName,
      required this.quantity});
}

class CartInfo with ChangeNotifier {
  late Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return (_items);
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0;
    print(_items);
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  void addItem(String productID, double price, String productName) {
    if (_items.containsKey(productID)) {
      _items.update(
          productID,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              productName: existingCartItem.productName,
              quantity: existingCartItem.quantity + 1));

      // change quantity
    } else {
      _items.putIfAbsent(
          productID,
          () => CartItem(
              id: DateTime.now().toString(),
              price: price,
              productName: productName,
              quantity: 1));
    }
  }

  void initialise() {
    _items = {};
  }
}

final cartInfoProvider = ChangeNotifierProvider<CartInfo>((ref) {
  final cartInfo = CartInfo();
  cartInfo.initialise();
  return cartInfo;
});
