import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:stripe_payment/firebase_service/auth_service.dart';
import 'package:stripe_payment/firebase_service/database.dart';
import 'package:stripe_payment/firebase_service/shared_pref.dart';
import 'package:stripe_payment/pages/walletPage.dart';
import 'package:stripe_payment/utils/myButton.dart';
import 'package:stripe_payment/utils/textfield.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;
  const SignUpPage({
    super.key,
    required this.onTap,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 120, right: 20, left: 20),
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
                "Sign up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
              const SizedBox(height: 20),
              Textfield(
                controller: _name,
                text: "Name",
                obscurtext: false,
                icon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 16, 34, 62),
                ),
              ),
              const SizedBox(height: 15),
              Textfield(
                text: "Email",
                obscurtext: false,
                icon: const Icon(
                  Icons.mail,
                  color: Color.fromARGB(255, 16, 34, 62),
                ),
                controller: _email,
              ),
              const SizedBox(height: 15),
              Textfield(
                text: "Password",
                obscurtext: false,
                icon: const Icon(
                  Icons.password,
                  color: Color.fromARGB(255, 16, 34, 62),
                ),
                controller: _password,
              ),
              const SizedBox(height: 15),
              Textfield(
                text: "Confirm Password",
                obscurtext: false,
                icon: const Icon(
                  Icons.password,
                  color: Color.fromARGB(255, 16, 34, 62),
                ),
                controller: _confirmPassword,
              ),
              const SizedBox(height: 30),
              MyButton(onTap: () => signUp(context), text: "Sign In"),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "ALREADY HAVE AN ACCOUNT?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 20, 42, 76),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontSize: 19,
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

  // final _auth = AuthService();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WalletPage()),
      );

  // _signUp() async {
  //   final user =
  //       await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
  //   if (user != null) {
  //     Text("${_name.text}account created succesfully");
  //     log("User created successfully");
  //     goToHome(context);
  //     // Text("User created successfully")
  //   }
  // }

  void signUp(BuildContext context) async {
    // auth service
    final authService = AuthService();
    // try log in
    if (_password.text == _confirmPassword.text) {
      try {
        await authService.createUserWithEmailAndPassword(
            _email.text, _password.text);
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
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            "Password don't match!",
          ),
        ),
      );

     
    }
    String Id = randomAlphaNumeric(10);

    Map<String, dynamic> addUserInfo = {
      "Name": _name.text,
      "email": _email.text,
      "Wallet": "0",
      "Id": Id,
    };
    await DatabaseMethods().addUserDetail(addUserInfo, Id);
    await SharedPreferenceHelper().saveUserName(_name.text);
    await SharedPreferenceHelper().saveUserEmail(_email.text);
    await SharedPreferenceHelper().saveUserWallet("0");
    await SharedPreferenceHelper().saveUserId(Id);
  }

  // String Id = randomAlphaNumeric(10);
  // Future addUserDetail() async {
  //   await FirebaseFirestore.instance.collection("users").add({
  //     // Map<String, dynamic> addUserInfo = {
  //     "Name": _name.text,
  //     "email": _email.text,
  //     "Wallet": "0",
  //     "Id": Id,
  //   });
  // }
}
