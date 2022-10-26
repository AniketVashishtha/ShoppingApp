import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/cart_indicator.dart';
import 'package:shopping_app/categories_screen.dart';
import 'package:shopping_app/category_item.dart';
import 'package:shopping_app/router.dart';
import './product_item.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/checkout_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shopping_app/categories_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class ProductItem {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;

  ProductItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.image,
      required this.category});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
        id: json['id'],
        title: json['title'],
        price: json['price'] is int ? json['price'].toDouble() : json['price'],
        image: json['image'],
        category: json['category']);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //fetchProducts();
    final router = AppRouter();
    return MaterialApp.router(
      routeInformationParser: router.router.routeInformationParser,
      routerDelegate: router.router.routerDelegate,
    );
  }
}

class ShopApp extends StatefulWidget {
  final String? final_category;
  ShopApp({this.final_category});
  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  List<ProductItem> products = [];
  void fetchProducts(final_category) async {
    final response = await http.get(
        Uri.parse('http://fakestoreapi.com/products/category/$final_category'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return Album.fromJson(jsonDecode(response.body));

      final rows = jsonDecode(response.body);
      for (var row in rows) {
        //print(row);
        products.add(ProductItem.fromJson(row));
      }
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    fetchProducts(widget.final_category);
    //filteredList = products;
    // filteredList = products
    //     .where((product) => product.category == widget.final_category)
    //     .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'),
        centerTitle: true,
        // leading: PopupMenuButton(itemBuilder: (context) {
        //   return List.generate(
        //       popList.length,
        //       (index) => PopupMenuItem(
        //             value: index,
        //             child: Text(popList[index]),
        //           ));
        // }, onSelected: (int value) {
        //   // filteredList = products
        //   //     .where((product) => product.category == popList[value])
        //   //     .toList();

        //   setState(() {});
        //}),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () => context.push('/checkout'),
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
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => Product(
          id: products[i].id,
          name: products[i].title,
          imgUrl: products[i].image,
          price: products[i].price,
        ),
      ),
    );
  }
}
