import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../Screens/login.dart';

class Splash extends StatefulWidget {
  static const routeName = '/';
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, Login.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assests/images/logo.png',
              height: 200,
            ),
            const SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              color: Theme.of(context).secondaryHeaderColor,
            )
          ],
        ),
      ),
    );
  }
}
