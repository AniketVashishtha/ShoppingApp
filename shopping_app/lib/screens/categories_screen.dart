import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/views/category_item.dart';
import 'package:http/http.dart' as http;

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> popList = [];
  List<String> popList_1 = [];
  List<Widget> popList_widget = [];
  void fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if (response.statusCode == 200) {
      //["jwellery","mens wear"]
      //print(response.body[1]);
      String oldBody = response.body;
      oldBody = oldBody.replaceFirst('[', '');
      oldBody = oldBody.replaceFirst(']', '');
      popList = oldBody.split(',');
      for (var i = 0; i < popList.length; i++) {
        popList[i] = popList[i].replaceAll('"', '');
      }
      popList_1 = popList.toSet().toList();
      popList_widget = [];
      for (var i = 0; i < popList_1.length; i++) {
        popList_widget.add(CategoryItem(popList_1[i]));
      }
      setState(() {});
      print('Printing popList Widget');
      print(popList_widget);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Categories'),
      ),
      body: GridView(
        children: popList_widget,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
