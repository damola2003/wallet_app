import 'package:flutter/material.dart';

class AddMoney extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const AddMoney({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(9),
      elevation: 5,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.height / 9.2,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 16, 34, 62),
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(9)),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )),
        ),
      ),
    );
  }
}
