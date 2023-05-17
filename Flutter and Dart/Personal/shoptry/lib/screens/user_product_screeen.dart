import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  static const routeName = '/yourProducts';
  @override
  Widget build(BuildContext context) {
    // final prods = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              }),
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (context, prods, _) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: ((context, index) => Column(
                                children: [
                                  UserProductItem(
                                      id: prods.items[index].id as String,
                                      title: prods.items[index].title,
                                      imageUrl: prods.items[index].imageUrl),
                                  Divider(),
                                ],
                              )),
                          itemCount: prods.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
