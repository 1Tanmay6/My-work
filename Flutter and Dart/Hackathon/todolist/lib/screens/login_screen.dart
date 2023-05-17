import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todolist/screens/Signup_screen.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart' as pro;

class LoginScreen extends StatefulWidget {
  static const routeName = './login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final service = pro.Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Enter Email'),
              controller: _emailController,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter Password'),
              controller: _passwordController,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, SignUpScreen.routeName);
                },
                child: Text('Don\'t have an account? signUp')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  String? email = _emailController.text;
                  String? password = _passwordController.text;

                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    await service.login(email: email, password: password);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error Fill the feilds')));
                  }
                },
                child: Text('Login')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await service.loginWithGithub(context: context);
                },
                child: Text('Github Login')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await service.loginWithGoogle(context: context);
                },
                child: Text('Google Login')),
          ]),
    );
  }
}
