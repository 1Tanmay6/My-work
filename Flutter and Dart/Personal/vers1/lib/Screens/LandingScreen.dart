import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = 'landing-page';
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  String? data = '-1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(data as String),
                ElevatedButton(
                    onPressed: () async {
                      String temp = '';

                      await Provider.of<LoginProvider>(context, listen: false)
                          .getTheUser();

                      String? id =
                          Provider.of<LoginProvider>(context, listen: false)
                              .id_get;
                      while (id == null) {
                        id = Provider.of<LoginProvider>(context, listen: false)
                            .id_get;
                      }
                      print(id);
                      // Navigator.pushNamed(context, TodoScreen.routeName);
                      Provider.of<LoginProvider>(context, listen: false)
                          .singout(context);
                      Navigator.pop(context);

                      setState(() {
                        data = id;
                      });
                    },
                    child: Text('Sign Out'))
              ]),
        ),
      ),
    );
  }
}
