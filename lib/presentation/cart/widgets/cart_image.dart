import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/presentation/cart/widgets/cart_product_img.dart';


class CartImage extends StatelessWidget {
  const CartImage({
    super.key,
    required this.kHeight,
    required this.kWidth,
    required this.theUrl,
  });

  final Size kHeight;
  final Size kWidth;
  final String theUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight.height * 0.1,
      width: kWidth.width * 0.25,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CartProductImage(anImageUrl: theUrl),
    );
  }
}
