import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import 'providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_product_screeen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) => Products(null, null, []),
            update: (context, auth, previous) {
              print(auth.token);
              return Products(auth.token, auth.userId, previous!.items);
            },
          ),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders(null, null, []),
            update: (context, auth, previous) {
              return Orders(auth.token, auth.userId, previous!.orders);
            },
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  appBarTheme: AppBarTheme(backgroundColor: Colors.brown),
                  primarySwatch: Colors.brown,
                  colorScheme:
                      theme.colorScheme.copyWith(secondary: Colors.black),
                  iconTheme: IconThemeData(color: Color(0xffc1974d)),
                  fontFamily: 'Lato'),
              home: auth.isAuth
                  ? ProductsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (context, authResultsnapshot) =>
                          authResultsnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
              routes: {
                ProductsOverviewScreen.routeName: (ctx) =>
                    ProductsOverviewScreen(),
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: ((ctx) => OrdersScreen()),
                UserProductScreen.routeName: (ctx) => UserProductScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
              },
            );
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ProductsOverviewScreen();
  }
}
