import 'package:flutter/material.dart';

class BlogTextField extends StatelessWidget {
  final String text;
  final TextEditingController cnt;
  const BlogTextField({super.key, required this.text, required this.cnt});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cnt,
      maxLines: null,
      decoration: InputDecoration(hintText: text),
      validator: (value) {
        if (value!.isEmpty) {
          return "$text is required!";
        }

        return null;
      },
    );
  }
}
