import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/models/cart_provider.dart';
import 'package:shopping_app/models/cart_info_provider.dart';

class Product extends ConsumerStatefulWidget {
  const Product({Key? key, this.name, this.price, this.imgUrl, this.id})
      : super(key: key);
  final String? name;
  final double? price;
  final String? imgUrl;
  final int? id;

  @override
  ConsumerState<Product> createState() => _ProductState();
}

class _ProductState extends ConsumerState<Product> {
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
        ));
  }
}
