import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';

class AllProductText extends StatelessWidget {
  const AllProductText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    double headSize = kHeight < 750 ? 15 : 20;
    final kHeadingText = TextStyle(
        fontWeight: FontWeight.bold, fontSize: headSize, color: kBlack);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 247, 0),
      child: Text(
        "All Products",
        style: kHeadingText,
      ),
    );
  }
}
