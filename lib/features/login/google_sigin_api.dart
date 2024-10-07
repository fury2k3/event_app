import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static FutureOr<GoogleSignInAccount?> login() async {
    final isUserConnected = await _googleSignIn.isSignedIn();
    if (isUserConnected) {
      await _googleSignIn.disconnect();
    }
    final user = await _googleSignIn.signIn();
    if (user == null) {
      return user;
    }
    return null;
  }
}
