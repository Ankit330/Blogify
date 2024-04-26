import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController cntllr;
  final bool isNotVissible;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.cntllr,
      this.isNotVissible = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cntllr,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is required!";
        }
        return null;
      },
      obscureText: isNotVissible,
    );
  }
}
