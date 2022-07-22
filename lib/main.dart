import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/Notifier/AddToCartProvider.dart';
import 'package:gift_registry_flutter/Notifier/ProductListProvider.dart';
import 'package:gift_registry_flutter/Notifier/WishListProvider.dart';
import 'package:gift_registry_flutter/view/AddToCartScreen.dart';
import 'package:gift_registry_flutter/view/ProductCategoryScreen.dart';
import 'package:gift_registry_flutter/view/ProductDetailsScreen.dart';
import 'package:gift_registry_flutter/view/ProductListScreen.dart';
import 'package:gift_registry_flutter/view/Wishlist.dart';

import 'package:provider/provider.dart';


void main() {
  runApp(Gift());
}
class Gift  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductListProvider>(
              create: (_) => ProductListProvider()),
         ChangeNotifierProvider<AddToCartProvider>(
              create: (_) => AddToCartProvider()),
          ChangeNotifierProvider<WishListProvider>(
              create: (_) => WishListProvider()),

        ],
        child:  MaterialApp(
            title: 'Gift Registry',
            debugShowCheckedModeBanner: false,
            home: ProductCategory(),
            routes: {
              ProductListScreen.routeName: (ctx) => ProductListScreen(),
              ProductCategory.routeName: (ctx) => ProductCategory(),
               AddToCartScreen.routeName : (ctx) => AddToCartScreen(),
               WishListScreen.routeName : (ctx) => WishListScreen(),
              ProductDetails.routeName : (ctx) => ProductDetails()
            }
        )
    );
  }
}

