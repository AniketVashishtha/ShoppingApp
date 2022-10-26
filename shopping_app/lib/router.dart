// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/cart_indicator.dart';
import 'package:shopping_app/categories_screen.dart';
import 'package:shopping_app/category_item.dart';
import './product_item.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/checkout_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shopping_app/categories_screen.dart';
import 'package:shopping_app/main.dart';

//void main() => runApp(App());

/// The main app.
class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/categories',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
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
        path: '/categories',
        builder: (BuildContext context, GoRouterState state) =>
            CategoriesScreen(),
      ),
    ],
  );
}
