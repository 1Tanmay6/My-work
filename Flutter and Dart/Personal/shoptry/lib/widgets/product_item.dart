import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductsItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductsItem({
  //   required this.id,
  //   required this.title,
  //   required this.imageUrl,
  // });

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            )),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: product.isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus(
                    authData.token as String, authData.userId as String);
              },
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            // style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              cart.addItem(product.id as String, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                action: SnackBarAction(
                  label: 'UNDO',
                  textColor: Theme.of(context).iconTheme.color,
                  onPressed: () {
                    cart.removeSingleItem(product.id as String);
                  },
                ),
                content: Text('Added item to cart!'),
                duration: Duration(seconds: 1),
              ));
            },
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
