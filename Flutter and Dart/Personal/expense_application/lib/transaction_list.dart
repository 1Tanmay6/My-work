import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteFunction;

  TransactionList(
      {required this.userTransaction, required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return userTransaction.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assests/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No Transaction Entered Yet.',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text('\$${userTransaction[index].amount}')),
                    ),
                  ),
                  title: Text(
                    userTransaction[index].title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(userTransaction[index].date!),
                  ),
                  trailing: mediaQuery.size.width > 560
                      ? TextButton.icon(
                          onPressed: () =>
                              deleteFunction(userTransaction[index].id),
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          label: Text('Delete'),
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              deleteFunction(userTransaction[index].id),
                        ),
                ),
              );
            },
            itemCount: userTransaction.length,
          );
  }
}
