import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/cart_info_provider.dart';

class Product extends ConsumerStatefulWidget {
  const Product({Key? key, this.name, this.price, this.imgUrl, this.id}) : super(key: key);
  final String? name;
  final int? price;
  final String? imgUrl;
  final int? id;

  @override
  ConsumerState<Product> createState() => _ProductState();
}

class _ProductState extends ConsumerState<Product> {
  @override

  // var count = 0;
  // void cartCounter() {
  //   count = count + 1;
  //   setState(() {});
  //   //String strCount = count.toString();
  //   print(count);
  // }

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Image.network(widget.imgUrl!, fit: BoxFit.cover),
        header: Text(widget.name!),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: const IconButton(
            icon: Icon(Icons.favorite),
            onPressed: null,
          ),
          title: Text(
            widget.price!.toString(),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              ref.read(cartProvider.notifier).increment();
              ref.read(cartInfoProvider.notifier).addItem(
                    widget.id.toString(),
                    widget.price!,
                    widget.name!,
                  );
            },
          ),
        )
        //footer: Text(price!),
        //Padding(
        //padding: const EdgeInsets.only(top: 80.0),
        //child: Text(price!),
        //),
        );
  }
}
