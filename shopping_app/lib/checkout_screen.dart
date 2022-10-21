import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/cart_info_provider.dart' show cartInfoProvider;
import 'package:shopping_app/cart_item.dart';

class Checkout extends ConsumerWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
        ),
        body: Column(children: <Widget>[
          Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 10),
                    Spacer(),
                    Chip(
                      // label: Text(ref
                      //     .read(cartInfoProvider.notifier)
                      //     .items
                      //     .length
                      //     .toString())

                      label: Text(ref
                          .read(cartInfoProvider.notifier)
                          .totalAmount
                          .toString()),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    ElevatedButton(
                        onPressed: () => {}, child: Text('ORDER NOW'))
                  ],
                ),
              )),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: ref.read(cartInfoProvider.notifier).items.length,
                itemBuilder: (ctx, i) {
                  print('Printing lenght');
                  print(ref.read(cartInfoProvider.notifier).items.length);

                  var ids =
                      ref.read(cartInfoProvider.notifier).items.keys.toList();
                  return CartItem(
                    id: ref.read(cartInfoProvider.notifier).items[ids[i]]!.id,
                    quantity: ref
                        .read(cartInfoProvider.notifier)
                        .items[ids[i]]!
                        .quantity,
                    name: ref
                        .read(cartInfoProvider.notifier)
                        .items[ids[i]]!
                        .productName,
                    price: ref
                        .read(cartInfoProvider.notifier)
                        .items[ids[i]]!
                        .price,
                  );
                }),
          )
        ]));
  }
}
