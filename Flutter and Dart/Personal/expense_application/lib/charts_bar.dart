import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal});

  double refinePct() {
    return spendingAmount == 0.0 ? 0.0 : spendingPctOfTotal;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, contsraints) {
        return Column(
          children: [
            Container(
                height: contsraints.maxHeight * 0.1,
                child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: contsraints.maxHeight * 0.05,
            ),
            Container(
              height: contsraints.maxHeight * 0.7,
              width: 25,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                FractionallySizedBox(
                  heightFactor: refinePct().toDouble(),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: contsraints.maxHeight * 0.05,
            ),
            Container(
                height: contsraints.maxHeight * 0.1,
                child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
