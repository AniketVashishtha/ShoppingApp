import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';
import 'package:go_router/go_router.dart';

class CategoryItem extends StatelessWidget {
  final String category;

  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
          child: InkWell(
              onTap: () => context.push('/', extra: category),
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
