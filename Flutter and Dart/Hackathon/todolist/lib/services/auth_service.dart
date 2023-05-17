import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../credentials/supabase_credentials.dart';
import 'package:supabase/supabase.dart';

class AuthService extends ChangeNotifier {
  SupabaseClient supabaseClient =
      SupabaseClient(SupabaseCredentials.URL, SupabaseCredentials.APIKey);
  Future<void> signup({required String email, required String password}) async {
    AuthResponse response =
        await supabaseClient.auth.signUp(email: email, password: password);

    print(response.session);
    print('===============================');
    print(response.user!.email);
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    AuthResponse response =
        await supabaseClient.auth.signUp(email: email, password: password);
    print(response.runtimeType);
    print(response);
    notifyListeners();
  }

  Future loginWithGithub({required BuildContext context}) async {
    try {
      var response = await supabaseClient.auth
          .getOAuthSignInUrl(provider: Provider.github);
      print(response.provider);
      print(response.url);
      print(response);
      if (response.url != null) {
        final Uri _url = Uri.parse(response.url.toString());
        launchUrl(_url);
      }
    } catch (e) {
      print(e);
    }
  }

  Future loginWithGoogle({required BuildContext context}) async {
    // try {
    AuthResponse response = await supabaseClient.auth.signInWithIdToken(
        provider: Provider.google,
        idToken:
            '660665287040-7ifm3235c1dpfhg0gjv2gcf88chdi9ni.apps.googleusercontent.com');
    print(response);
    // print(response.url);
    // if (response.url != null) {
    //   final Uri _url = Uri.parse(response.url.toString());
    //   launchUrl(_url);
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }
}
