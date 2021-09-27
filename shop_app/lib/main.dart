import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 'value:' is used when context is not needed and object is already initiated (ex. products[i])
    // value: Products(), 
    // 'create:' is used when new object is initiated(ex. Products())
    return  MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (ctx) => Products(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => Cart(),
      ),
      ], 
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.lightGreen,
          fontFamily: 'Lato'
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}


