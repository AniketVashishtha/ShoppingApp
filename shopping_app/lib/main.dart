import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/cart_indicator.dart';
import './product_item.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/checkout_screen.dart';
import 'package:shopping_app/laptop.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ShopApp());
  }
}

class ShopApp extends StatelessWidget {
  //const ShopApp({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "category": "Mobile",
      "name": "Iphone 13",
      'Image':
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-model-unselect-gallery-1-202207?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1654893619853',
      "price": "150000",
    },
    {
      "id": 2,
      "category": "Mobile",
      "name": "Samsung Galaxy",
      'Image':
          'https://images.samsung.com/is/image/samsung/assets/in/smartphones/galaxy-z-fold3-5g/buy/ZFold3_Carousel_MainSingleKV_withDisclaimer_PC.jpg?imwidth=1536',
      "price": "50000",
    },
    {
      "id": 3,
      "category": "Laptop",
      "name": "Macook Pro",
      'Image':
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mbp16-spacegray-select-202110?wid=904&hei=840&fmt=jpeg&qlt=90&.v=1632788574000',
      "price": '150000',
    },
    {
      "id": 4,
      "category": "Laptop",
      "name": "IBM Thinkpad",
      'Image': 'https://i.ytimg.com/vi/ftn1VrCPVpk/maxresdefault.jpg',
      "price": '50000',
    },
  ];

  get leading => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping App'),
          centerTitle: true,
          leading: PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return const [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Phones"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Laptops"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopApp()),
              );
            } else if (value == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Laptop()),
              );
            }
          }),
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
            id: products[i]['id']!,
            name: products[i]['name']!,
            imgUrl: products[i]['Image']!,
            price: int.parse(products[i]['price']!),
          ),
        ));
  }
}
