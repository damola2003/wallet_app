import 'package:flutter/material.dart';
import 'package:stripe_payment/utils/container.dart';
// import 'package:stripe_payment/utils/myButton.dart';

class PayNowContainer extends StatelessWidget {
  const PayNowContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Amount",
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            AddMoney(
              text: "Add",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
