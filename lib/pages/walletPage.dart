// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/constants.dart';
import 'package:stripe_payment/firebase_service/auth_service.dart';
import 'package:stripe_payment/firebase_service/database.dart';
import 'package:stripe_payment/firebase_service/shared_pref.dart';
import 'package:stripe_payment/utils/container.dart';
import 'package:stripe_payment/utils/myButton.dart';

// import 'package:http/http.dart' as http;

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String? wallet, id;
  int? add;
  TextEditingController amountController = new TextEditingController();

  gettheSharedpred() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheLoad() async {
    await gettheSharedpred();
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

  @override
  Map<String, dynamic>? paymentIntent;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        elevation: 5,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logOut(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: wallet == null
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    // Text("Welcome ${_name.text}"),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.height / 11.3,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.wallet,
                                color: Color.fromARGB(255, 16, 34, 62),
                                size: 60,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Wallet",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Colors.grey[700]),
                                  ),
                                  Text(
                                    "\$" + wallet!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Add Money",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddMoney(
                          text: "\$" "100",
                          onTap: () {
                            makePayment('100');
                          },
                        ),
                        const SizedBox(width: 6),
                        AddMoney(
                          text: "\$" "500",
                          onTap: () {
                            makePayment('500');
                          },
                        ),
                        const SizedBox(width: 6),
                        AddMoney(
                          text: "\$" "1000",
                          onTap: () {
                            makePayment('1000');
                          },
                        ),
                        const SizedBox(width: 6),
                        AddMoney(
                          text: "\$" "2000",
                          onTap: () {
                            makePayment('2000');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: MyButton(
                        onTap: () {
                          openEdit();
                        },
                        text: "Add Money",
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "USD");
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntent!['client_secret'],
                style: ThemeMode.dark,
                merchantDisplayName: "Damola"),
          )
          .then((value) {});
      displayPaymentSheet(amount);
    } catch (e, s) {
      print("exception: $e$s");
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
        (value) async {
          add = int.parse(wallet!) + int.parse(amount);
          await SharedPreferenceHelper().saveUserWallet(add.toString());
          await DatabaseMethods().updateUsersWallet(id!, add.toString());
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color.fromARGB(255, 16, 34, 62),
                  ),
                  Text("Payment Successful"),
                ],
              ),
            ),
          );

          await gettheSharedpred();
          // await userGetProfile();
          paymentIntent = null;
        },
      ).onError((error, StackTrace) {
        print("Error is: --->$error$StackTrace");
      });
    } on StripeException catch (e) {
      print("Error is: --->$e");
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (e) {
      // print("$e");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': caculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Authorization": "Bearer $secretKey",
            'Content-Type': 'application/x-www-form-urlencoded'
          }));
      if (response.data != null) {
        // print("Payment Intent Body--->${response.data.toString()}");
        // return jsonDecode(response.data);
        return response.data;
        // return "";
      }
      return null;
    } catch (err) {
      print("error changing user: ${err.toString()}");
    }
  }

  caculateAmount(String amount) {
    int caculatdAmount = (int.parse(amount) * 100);
    return caculatdAmount.toString();
  }

  Future openEdit() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.cancel),
                        ),
                        const SizedBox(width: 60),
                        const Center(
                          child: Text(
                            "Add Money",
                            style: TextStyle(
                              color: Color.fromARGB(255, 16, 34, 62),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text("Amount"),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 16, 34, 62),
                              width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: amountController,
                        decoration: const InputDecoration(
                          hintText: "Enter Amount",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                        onTap: () {
                          Navigator.pop(context);
                          makePayment(amountController.text);
                        },
                        text: "Pay Now")
                  ],
                ),
              ),
            ),
          ));

  void logOut() {
    final auth = AuthService();

    auth.signout();
  }
}
