import 'package:crudsupa/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart' as pro;

class AuthService extends ChangeNotifier {
  String? id = null;

  final SupabaseClient _supabaseClient = Supabase.instance.client;

  String? get id_get => id;

  Future<void> signupWithPass(
      String email, String password, BuildContext context) async {
    final AuthResponse res = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    print(user!.id);
    print('===========================================');
    print(session!.refreshToken);
    Navigator.pushNamed(context, LandingPage.routeName);
  }

  Future<void> signorlogInWithGithub(BuildContext context) async {
    bool res = await _supabaseClient.auth.signInWithOAuth(
      Provider.github,
      context: context,
      // scopes: 'repo gist notifications',
    );
    print('===============================================');
    print(res);

    // print(_supabaseClient.auth.admin);
    getTheUser();
    // final User? user = res.user;
    // if (res) {
    //   Navigator.pushNamed(context, LandingPage.routeName);
    // }
  }

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
      Navigator.pushNamed(context, LandingPage.routeName);
    }
  }

  Future<String> getTheUser() async {
    // _supabaseClient.auth.
    // final data = await _supabaseClient.from('cities').select('name');
    User? user = await _supabaseClient.auth.currentUser;

    String temp_id = user!.id;
    id = temp_id;
    print(id);
    return user.id;
  }

  Future<void> singout() async {
    await _supabaseClient.auth.signOut();
    print('done');
  }
}
