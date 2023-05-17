import 'package:crudsupa/auth_service.dart';
import 'package:crudsupa/demo_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'demo_todo2.dart';

class LandingPage extends StatefulWidget {
  static const routeName = 'landing';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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

                      await Provider.of<AuthService>(context, listen: false)
                          .getTheUser();

                      String? id =
                          Provider.of<AuthService>(context, listen: false)
                              .id_get;
                      while (id == null) {
                        id = Provider.of<AuthService>(context, listen: false)
                            .id_get;
                      }
                      print(id);
                      Navigator.pushNamed(context, TodoScreen.routeName);

                      // .singout();
                      // Navigator.pop(context);

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
