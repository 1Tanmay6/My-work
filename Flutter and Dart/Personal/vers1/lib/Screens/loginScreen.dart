import 'package:flutter/material.dart';

import '../widgets/login_widget.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  Widget _gradientLoginButtons(
      String content, String path, BuildContext context, int parity) {
    final media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Nahi')));
      },
      child: Container(
          width: media.width * 0.9,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.45),
                Colors.black.withOpacity(0.45)
              ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                  child: Image.asset(
                path,
                fit: BoxFit.contain,
                height: 45,
                width: 45,
              )),
              Container(width: media.width * (0.6), child: Text(content))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'lib/assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: textTheme.labelMedium,
                ),
                SizedBox(
                  height: media.height * 0.09,
                ),
                Text(
                  'To login, enter your email address',
                  style: textTheme.displaySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: media.height * 0.05,
                ),
                LoginWidget(),
                SizedBox(
                  height: media.height * 0.05,
                ),
                Text(
                  'else, login with',
                  style: textTheme.displaySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: media.height * 0.05,
                ),
                _gradientLoginButtons('Login with Google',
                    'lib/assets/images/logo/google.png', context, 0),
                SizedBox(
                  height: media.height * 0.05,
                ),
                _gradientLoginButtons('Login with GitHub',
                    'lib/assets/images/logo/github-logo.png', context, 1),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
