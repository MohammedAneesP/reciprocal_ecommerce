import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';

class NoProductInCart extends StatelessWidget {
  const NoProductInCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "CART",
          style: kTitleText,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: kHeight.height * 0.35,
            child: LottieBuilder.asset(
              "assets/animation_lnpkse54.json",
              height: kHeight.height * 0.2,
              width: kWidth.width * 1,
            ),
          ),
          const Text("You haven't added any Products to cart"),
          SizedBox(height: kHeight.height * 0.01),
        ],
      ),
    );
  }
}
