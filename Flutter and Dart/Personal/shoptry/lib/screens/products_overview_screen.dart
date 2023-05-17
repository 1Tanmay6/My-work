import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../providers/products.dart';
import '../widgets/badge.dart' as ba;
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';
import './cart_screen.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = 'products-overview';
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showonlyFavrites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // of(context) won't work in init class.

    // if we have to use the of(context) in init blokc do:
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
            title: Text('MyShop'),
            actions: [
              PopupMenuButton(
                  onSelected: (FilterOptions selectedValue) {
                    setState(() {
                      if (selectedValue == FilterOptions.favorites) {
                        _showonlyFavrites = true;
                      } else {
                        _showonlyFavrites = false;
                      }
                    });
                  },
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (_) => [
                        PopupMenuItem(
                            child: Text('Only Favorites'),
                            value: FilterOptions.favorites),
                        PopupMenuItem(
                            child: Text('Show All'), value: FilterOptions.all),
                      ]),
              Consumer<Cart>(
                builder: (_, cart, child) => ba.Badge(
                  color: Theme.of(context).primaryColor,
                  child: child as Widget,
                  value: cart.itemCount.toString(),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.routeName);
                    },
                    icon: Icon(Icons.shopping_cart)),
              ),
            ],
            backgroundColor: Theme.of(context).primaryColor),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : ProductsGrid(_showonlyFavrites));
  }
}
