import 'package:flutter/material.dart';

class FildForm extends StatelessWidget {
  String Label;
  bool isPassword;
  TextEditingController controller;
  bool? isForm = true;
  bool isEmail = false;

  FildForm({
    required this.Label,
    required this.isPassword,
    required this.controller,
    this.isForm,
    required this.isEmail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: this.isForm,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: Label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.length < 4) {
          return " Must have at least 4 characters";
        }
        if (this.isEmail && !value.contains("9")) {
          return " Type the number correctly";
        }
      },
    );
  }
}
