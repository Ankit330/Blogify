import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LodingIndicator extends StatelessWidget {
  const LodingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 50,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [AppPallete.gradient2, AppPallete.gradient1],
        ),
      ),
    );
  }
}
