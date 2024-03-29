import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

import './helpers/custom_route.dart';
import './screens/splash_screen.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 'value:' is used when context is not needed and object is already initiated (ex. products[i])
    // 'create:' is used when new object is initiated(ex. Products())
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        // Syntax <Auth, Products>, Auth - class we depend on, Products - class that we will provide
        ChangeNotifierProxyProvider<Auth, Products>(
          // ChNotPr. with create Auth() has to be before this
          // create: (ctx) => Products('', []), // may be needed
          // auth object is taken from ChangeNotifierProvider => Auth(), when Auth changes this rebuilds
          // on rebuild we need to save old data(previousProducts)
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previusOrders) => Orders(
            auth.token,
            auth.userId,
            previusOrders == null ? [] : previusOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.lightGreen,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            }),
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            CartScreen.routeName: (ctx) =>
                auth.isAuth ? CartScreen() : AuthScreen(),
            ProductDetailScreen.routeName: (ctx) =>
                auth.isAuth ? ProductDetailScreen() : AuthScreen(),
            OrdersScreen.routeName: (ctx) =>
                auth.isAuth ? OrdersScreen() : AuthScreen(),
            UserProductsScreen.routeName: (ctx) =>
                auth.isAuth ? UserProductsScreen() : AuthScreen(),
            EditProductScreen.routeName: (ctx) =>
                auth.isAuth ? EditProductScreen() : AuthScreen(),
          },
        ),
      ),
    );
  }
}
