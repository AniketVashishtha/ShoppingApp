import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/cart_provider.dart';

class CartIndicator extends ConsumerWidget {
//   const CartIndicator
// ({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(cartProvider).toString(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
