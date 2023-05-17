import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:provider/provider.dart' as pro;
import 'package:email_validator/email_validator.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/sign-up';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
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
              keyboardType: TextInputType.emailAddress,
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
            TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Confirm Password'),
              controller: _repeatPasswordController,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Login.routeName);
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
                      EmailValidator.validate(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Enter a valid email')));
                  }

                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    if (_passwordController.text ==
                        _repeatPasswordController.text) {
                      await service.signupWithPass(email, password, context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwords doesn\'t match')));
                    }
                    // await service.login(email: email, password: password);
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
                  await service.signorlogInWithGithub(context);
                },
                child: Text('Github Login')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  // await service.loginWithGoogle(context: context);
                },
                child: Text('Google Login')),
          ]),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }
}
