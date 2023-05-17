import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/transaction.dart';
import './charts_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTrasactionValues {
    return List.generate(7, (ind) {
      final weekDay = DateTime.now().subtract(Duration(days: ind));
      double totalSum = 0.0;

      for (var i = 0; i <= recentTransactions.length - 1; i++) {
        if (recentTransactions[i].date?.day == weekDay.day &&
            recentTransactions[i].date?.month == weekDay.month &&
            recentTransactions[i].date?.year == weekDay.year) {
          totalSum += recentTransactions[i].amount as double;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTrasactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTrasactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data['day'] as String,
                  spendingAmount: data['amount'] as double,
                  spendingPctOfTotal: (totalSpending == double.nan
                          ? 0.0
                          : data['amount'] as double) /
                      totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
