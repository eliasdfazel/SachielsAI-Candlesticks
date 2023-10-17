/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/26/23, 8:05 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationsCallback {
  void authenticationWithPhoneCompleted();
  void authenticationCodeSent(String verificationId);
}

class AuthenticationsProcess {

  Future<UserCredential> startGoogleAuthentication() async {
    debugPrint("Start Google Authentication Process");

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuthentication = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuthentication?.accessToken,
      idToken: googleAuthentication?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future startPhoneNumberAuthentication(String enteredPhoneNumber, AuthenticationsCallback authenticationsCallback) async {
    debugPrint("Start Phone Authentication Process");

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: enteredPhoneNumber,
      timeout: const Duration(seconds: 119),
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        debugPrint("Phone Authentication Completed");

        FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneAuthCredential);

        authenticationsCallback.authenticationWithPhoneCompleted();

      },
      verificationFailed: (FirebaseAuthException exception) {
        debugPrint("Phone Authentication Failed \n ${exception.code}: ${exception.message}");


      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint("Phone Authentication Code Sent");

        authenticationsCallback.authenticationCodeSent(verificationId);

      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint("Phone Authentication Timeout");


      },
    );

  }

}