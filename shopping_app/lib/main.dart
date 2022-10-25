import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/cart_indicator.dart';
import './product_item.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/checkout_screen.dart';
import 'package:shopping_app/laptop.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

List<ProductItem> products = [];
List<String> popList = [];
List<ProductItem> filteredList = [];

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

void fetchProducts() async {
  final response =
      await http.get(Uri.parse('http://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //return Album.fromJson(jsonDecode(response.body));

    final rows = jsonDecode(response.body);
    for (var row in rows) {
      //print(row);
      products.add(ProductItem.fromJson(row));
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void fetchCategories() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

  if (response.statusCode == 200) {
    //print(response.body[1]);
    String oldBody = response.body;
    oldBody = oldBody.replaceFirst('[', '');
    oldBody = oldBody.replaceFirst(']', '');
    popList = oldBody.split(',');
    for (var i = 0; i < popList.length; i++) {
      popList[i] = popList[i].replaceAll('"', '');
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    fetchProducts();
    fetchCategories();
    return MaterialApp(home: ShopApp());
  }
}

class ShopApp extends StatefulWidget {
  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  //final popList = fetchCategories();
  // final popList = [
  //   "electronics",
  //   "jewelery",
  //   "men's clothing",
  //   "women's clothing"
  // ];
  //final popList = categories;

  //const ShopApp({Key? key}) : super(key: key);
  //get leading => null;
  @override
  void initState() {
    filteredList = products;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping App'),
          centerTitle: true,
          leading: PopupMenuButton(itemBuilder: (context) {
            return List.generate(
                popList.length,
                (index) => PopupMenuItem(
                      value: index,
                      child: Text(popList[index]),
                    ));
          }, onSelected: (int value) {
            filteredList = products
                .where((product) => product.category == popList[value])
                .toList();

            setState(() {});
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
          itemCount: filteredList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => Product(
            id: filteredList[i].id,
            name: filteredList[i].title,
            imgUrl: filteredList[i].image,
            price: filteredList[i].price,
          ),
        ));
  }
}
