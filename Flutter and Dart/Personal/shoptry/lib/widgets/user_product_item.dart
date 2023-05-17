import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
      {required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      trailing: Container(
        alignment: Alignment.centerRight,
        width: 100,
        child: Row(children: [
          IconButton(
              onPressed: (() {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              }),
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              )),
          IconButton(
              onPressed: (() {
                try {
                  Provider.of<Products>(context, listen: false)
                      .delteProducts(id);
                } catch (e) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text(
                      'Deleting Failed',
                      textAlign: TextAlign.center,
                    ),
                  ));
                }
              }),
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ]),
      ),
    );
  }
}
