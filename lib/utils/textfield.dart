import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool obscurtext;
  final Icon icon;
  const Textfield({
    super.key,
    required this.controller,
    required this.text,
    required this.obscurtext,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscurtext,
      decoration: InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: icon,
          labelText: text,
          fillColor: Color.fromARGB(255, 242, 236, 236),
          filled: true),
    );
  }
}
