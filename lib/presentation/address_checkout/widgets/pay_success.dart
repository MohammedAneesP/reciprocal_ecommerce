import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessWidget extends StatelessWidget {
  const PaymentSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return SizedBox(
      height: kHeight.height * 0.35,
      child: LottieBuilder.asset(
        "assets/animation_lnfmvkl2.json",
        height: kHeight.height * 0.2,
        width: kWidth.width * 1,
      ),
    );
  }
}