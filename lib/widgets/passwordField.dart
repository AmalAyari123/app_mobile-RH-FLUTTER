// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController mycontroller;

  final String? Function(String?)? validator;
  final bool obscureText;
  const CustomTextForm(
      {super.key,
      required this.mycontroller,
      this.validator,
      this.obscureText = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: mycontroller,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 53, 15, 52)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 127, 118, 117)),
        ),
      ),
    );
  }
}
