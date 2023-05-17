import 'package:flutter/material.dart';

import '../new_transactions.dart';
import '../transaction_list.dart';
import '../../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransaction = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 79.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Groceries', amount: 19.99, date: DateTime.now()),
  ];

  void _addNewTransactions(String title, double amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransactions),
        TransactionList(
          userTransaction: _userTransaction,
          deleteFunction: () {},
        ),
      ],
    );
  }
}
