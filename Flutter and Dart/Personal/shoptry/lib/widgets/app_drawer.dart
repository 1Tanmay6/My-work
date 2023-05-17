import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/products_overview_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/user_product_screeen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [BoxShadow(blurRadius: 5)]),
            alignment: Alignment.center,
            height: 75,
            width: double.infinity,
            child: Text(
              'Hello friend!',
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight, fontSize: 20),
            ),
          ),
          // AppBar(
          //   title: Text('Hello Friend!'),
          // ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductsOverviewScreen(),
              ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Your Products'),
            onTap: () {
              Navigator.of(context).pushNamed(UserProductScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
              // Navigator.of(context).pushNamed(UserProductScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
