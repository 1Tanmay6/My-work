import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pro;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Screens/LandingScreen.dart';
import '../Screens/DashboardScreen.dart';
import '../Screens/loginScreen.dart';

class LoginProvider extends ChangeNotifier {
  String? id = null;

  final SupabaseClient _supabaseClient = Supabase.instance.client;

  String? get id_get => id;

  String _email = '';
  String _password = '';

  void emailSetter(String email) {
    _email = email;
  }

  void passSetter(String password) {
    _password = password;
  }

  String get emailGetter => _email;
  String get passGetter => _password;

  Future<void> signinWithPass(
      String email, String password, BuildContext context) async {
    final AuthResponse res = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    print(user!.id);
    print('===========================================');
    print(session);
    if (session!.refreshToken != null) {
      Navigator.pushNamed(context, DashboardScreen.routeName);
    }
  }

  Future<String> getTheUser() async {
    User? user = await _supabaseClient.auth.currentUser;

    String temp_id = user!.id;
    id = temp_id;
    print(id);
    return user.id;
  }

  Future<void> singout(BuildContext context) async {
    await _supabaseClient.auth.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    print('done');
  }
}
