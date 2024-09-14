import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:stripe_payment/pages/walletPage.dart';
import 'package:stripe_payment/utils/signInSignUp.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snaoshot) {
          // user is logged in
          if (snaoshot.hasData) {
            return const WalletPage();
          }
          // User is not logged in
          else {
            return const LoginRegisterPage();
          }
        },
      ),
    );
  }
}
