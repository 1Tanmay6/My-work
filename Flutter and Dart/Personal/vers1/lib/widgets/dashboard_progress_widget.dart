import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class DashBoardProgressWidget extends StatefulWidget {
  const DashBoardProgressWidget({super.key});

  @override
  State<DashBoardProgressWidget> createState() =>
      _DashBoardProgressWidgetState();
}

class _DashBoardProgressWidgetState extends State<DashBoardProgressWidget> {
  double percentageCalculator(double currentScore, double totalScore) {
    double percentage = (currentScore / totalScore) * 100;
    print(percentage);
    return (percentage / 2);
  }

  double currentScore(BuildContext context) {
    // database le lo current score
    return 300;
  }

  double totalScore(BuildContext context) {
    return 300;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.transparent,
          width: double.infinity,
          height: media.height * 0.3,
          child: SimpleCircularProgressBar(
            size: media.width * 0.6,
            backStrokeWidth: 35,
            progressStrokeWidth: 35,
            animationDuration: 3,
            progressColors: [
              colorScheme.secondaryVariant,
              colorScheme.primary,
            ],
            startAngle: 270,
            mergeMode: true,
            valueNotifier: ValueNotifier(percentageCalculator(
                currentScore(context), totalScore(context))),
            backColor: Colors.transparent,
          ),
        ),
        Container(
          width: media.width * 0.6,
          height: media.width * 0.6,
          color: Colors.transparent,
          child: Image.asset(
            'lib/assets/images/avatar.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
