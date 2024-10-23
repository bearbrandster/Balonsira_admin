import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final suffixIcon;
  final prefixIcon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const Mytextfield(
      {super.key,
      required this.suffixIcon,
      required this.prefixIcon,
      required this.hintText,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 17),
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 62, 56, 56)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }
}
