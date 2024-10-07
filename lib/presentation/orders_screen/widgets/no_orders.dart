
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoOrders extends StatelessWidget {
  const NoOrders({
    super.key,
    required this.kHeight,
  });

  final Size kHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: kHeight.height * .5,
          child: Column(
            children: [
              SizedBox(
                height: kHeight.height * 0.35,
                child: LottieBuilder.asset(
                  "assets/animation_lnpkse54.json",
                  height: kHeight.height * 0.2,
                  width: kHeight.width * 1,
                ),
              ),
              const Text("You haven't Ordered any Products"),
              SizedBox(height: kHeight.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}
