import 'package:flutter/material.dart';

import 'category_meals_screen.dart';

class ErrorScreen extends StatelessWidget {
  static const gotoName = '/';

  void back(BuildContext ctx) {
    Navigator.popAndPushNamed(ctx, gotoName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ERROR 404'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Error occured'),
            TextButton.icon(
                onPressed: () => back(context),
                icon: Icon(Icons.keyboard_arrow_left_outlined),
                label: Text('Back'))
          ],
        ),
      ),
    );
  }
}
