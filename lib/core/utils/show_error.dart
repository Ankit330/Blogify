import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

void showError(BuildContext cnt, String content) {
  ScaffoldMessenger.of(cnt)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppPallete.backgroundColor,
        content: Center(
          child: Text(
            content,
            style: const TextStyle(color: AppPallete.whiteColor),
          ),
        ),
      ),
    );
}
