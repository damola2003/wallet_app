import 'package:flutter/material.dart';
import 'package:stripe_payment/pages/signIn.dart';
import 'package:stripe_payment/pages/signUp.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  // show log in page

  bool showLogInPage = true;
  // toggle between log in and register page

  void togglePages() {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogInPage) {
      return SignInPage(
        onTap: togglePages,
      );
    } else {
      return SignUpPage(onTap: togglePages);
    }
  }
}
