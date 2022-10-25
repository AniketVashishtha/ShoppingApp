import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';

class CategoryItem extends StatelessWidget {
  //const CategoryItem({ Key? key }) : super(key: key);
  final String category;

  CategoryItem(this.category);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ShopApp(final_category: category);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
          child: InkWell(
              onTap: () => selectCategory(context),
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Text(category),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.7),
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15)),
              ))),
    );
  }
}
