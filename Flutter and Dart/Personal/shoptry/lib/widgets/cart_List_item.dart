import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartListItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartListItem(
      {required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Theme.of(context).primaryColor,
                title: Text(
                  'Are You Sure?',
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
                content: Text(
                  'Do you want to remove the item?',
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        'Yes',
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No',
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color))),
                ],
              );
            }));
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      key: ValueKey(id),
      background: Container(
        child: Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        color: Colors.red,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(child: Text('\$${price}')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
