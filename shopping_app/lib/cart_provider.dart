import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<Cart, int>((ref) {
  return Cart();
});

class Cart extends StateNotifier<int> {
  Cart() : super(0);
  void increment() => state++;
}
