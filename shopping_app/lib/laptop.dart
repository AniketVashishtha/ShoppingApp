import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/cart_indicator.dart';
import './product_item.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/checkout_screen.dart';
import 'package:shopping_app/laptop.dart';

class Laptop extends StatelessWidget {
  //const Laptop({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> laptops = [
    {
      "id": 3,
      "name": "Macook Pro",
      'Image':
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mbp16-spacegray-select-202110?wid=904&hei=840&fmt=jpeg&qlt=90&.v=1632788574000',
      "price": '150000',
    },
    {
      "id": 4,
      "name": "IBM Thinkpad",
      'Image': 'https://i.ytimg.com/vi/ftn1VrCPVpk/maxresdefault.jpg',
      "price": '50000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Laptop'),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Checkout()),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    size: 30,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 6,
                  child: Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      child: CartIndicator()),
                ),
              ],
            ),
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: 2,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => Product(
            name: laptops[i]['name']!,
            imgUrl: laptops[i]['Image']!,
            price: laptops[i]['price']!,
          ),
        ));
  }
}
