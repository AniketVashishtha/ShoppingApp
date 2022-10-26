import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/views/cart_indicator.dart';
import 'package:shopping_app/screens/categories_screen.dart';
import 'package:shopping_app/views/category_item.dart';
import 'views/product_item.dart';
import 'package:shopping_app/models/cart_provider.dart';
import 'package:shopping_app/screens/checkout_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shopping_app/screens/categories_screen.dart';
import 'package:shopping_app/main.dart';

//void main() => runApp(App());

/// The main app.
class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/categories',
    routes: <GoRoute>[
      GoRoute(
        path: '/categories/:category',
        builder: (BuildContext context, GoRouterState state) => ShopApp(
          final_category: state.extra as String,
        ),
      ),
      GoRoute(
        path: '/checkout',
        builder: (BuildContext context, GoRouterState state) =>
            const Checkout(),
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            CategoriesScreen(),
      ),
      GoRoute(
        path: '/categories/:category/product/:id',
        builder: (BuildContext context, GoRouterState state) => ShopApp(
          final_category: state.extra as String,
        ),
      ),
    ],
  );
}
