
import 'package:flutter/material.dart';
import 'package:stripe_payment/firebase_service/auth_service.dart';

import 'package:stripe_payment/pages/walletPage.dart';
import 'package:stripe_payment/utils/myButton.dart';
import 'package:stripe_payment/utils/textfield.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;
  SignInPage({
    super.key,
    required this.onTap,
  });

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 200, right: 20, left: 20),
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(32, 158, 158, 158),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.wallet,
                color: Color.fromARGB(255, 16, 34, 62),
                size: 80,
              ),
              const Text(
                "Sign In",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
              const SizedBox(height: 20),
              Textfield(
                text: "Email",
                obscurtext: false,
                icon: const Icon(Icons.mail),
                controller: _emailController,
              ),
              const SizedBox(height: 15),
              Textfield(
                text: "Password",
                obscurtext: true,
                icon: const Icon(Icons.password),
                controller: _passwordController,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("FORGOT PASSWORD")],
              ),
              const SizedBox(height: 30),
              MyButton(
                onTap: () => logIn(context),
                text: "Log In",
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "DON'T HAVE AN ACCOUNT?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 20, 42, 76),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 16, 34, 62),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WalletPage()),
      );

  void logIn(BuildContext context) async {
    // auth service
    final authService = AuthService();
    // try log in
    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      goToHome(context);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

 
}
