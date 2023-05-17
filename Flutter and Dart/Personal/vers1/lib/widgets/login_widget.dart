import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vers1/provider/login_provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  bool _emailFocus = true;

  @override
  Widget build(BuildContext context) {
    final _login_provider = Provider.of<LoginProvider>(context, listen: false);
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return (_emailFocus)
        ? Container(
            height: media.height * 0.06,
            width: media.width * 0.9,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.45),
                  Colors.black.withOpacity(0.45)
                ])),
            child: TextField(
              controller: _emailcontroller,
              onSubmitted: (value) => _emailFocus = false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'example@mail.com',
                hintStyle: textTheme.bodyMedium,
                border: InputBorder.none,
                // hintStyle:
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            height: media.height * 0.06,
            width: media.width * 0.9,
            padding: EdgeInsets.only(left: 10, right: 10, top: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.45),
                  Colors.black.withOpacity(0.45)
                ])),
            child: TextField(
              obscureText: true,
              controller: _passcontroller,
              onSubmitted: (value) {
                if (_emailcontroller.text.isNotEmpty &&
                    _passcontroller.text.isNotEmpty) {
                  if (_emailcontroller.text.contains('@') &&
                      _emailcontroller.text.contains('.')) {
                    if (!(_passcontroller.text.length <= 6)) {
                      _login_provider.emailSetter(_emailcontroller.text);
                      _login_provider.passSetter(_passcontroller.text);
                      final email = _login_provider.emailGetter;
                      final password = _login_provider.passGetter;
                      _login_provider.signinWithPass(email, password, context);
                      _emailFocus = true;
                      _passcontroller.text = '';
                      _emailcontroller.text = '';
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        'Enter password of length greater than 6',
                        style:
                            textTheme.bodyMedium!.copyWith(color: Colors.black),
                      )));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Wrong email',
                      style:
                          textTheme.bodyMedium!.copyWith(color: Colors.black),
                    )));
                    _emailFocus = true;
                    _passcontroller.text = '';
                    _emailcontroller.text = '';
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'Empty fields found!',
                    style: textTheme.bodyMedium!.copyWith(color: Colors.black),
                  )));
                  _emailFocus = true;
                  _passcontroller.text = '';
                  _emailcontroller.text = '';
                }
              },
              autofocus: true,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: '*************',
                hintStyle: textTheme.bodyMedium,
                border: InputBorder.none,
              ),
            ),
          );
  }
}
