import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:supabase/supabase.dart';
import 'package:todolist/screens/Signup_screen.dart';
import 'package:provider/provider.dart' as pro;
import 'package:todolist/screens/login_screen.dart';
import 'package:todolist/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class SignUpScreen extends StatefulWidget {
  static const routeName = './signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        title: Text('Sign Up'),
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
                      context, LoginScreen.routeName);
                },
                child: Text('Already have an account? Login')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  String? email = _emailController.text;
                  String? password = _passwordController.text;

                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    await service.signup(email: email, password: password);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error Fill the feilds')));
                  }
                },
                child: Text('Sign Up')),
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
