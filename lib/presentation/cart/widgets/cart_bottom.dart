
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/presentation/address_checkout/checkout.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    super.key,
    required this.kheight,
    required this.totalPrice,
    required this.toSaveIn,
  });

  final Size kheight;
  final ValueNotifier<int> totalPrice;
  final Map<String, dynamic> toSaveIn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kheight.height * 0.15,
      width: kheight.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Cost", style: kTitleNonBoldText),
                ValueListenableBuilder(
                  valueListenable: totalPrice,
                  builder: (context, value, child) {
                    return Text(
                      "\$ ${totalPrice.value}",
                      style: kTitleNonBoldText,
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Checkout(
                          products: toSaveIn,
                          totalCost: totalPrice.value),
                    ));
              },
              style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(Colors.amberAccent),
                minimumSize: WidgetStatePropertyAll(
                  Size(
                    kheight.width,
                    kheight.height * 0.07,
                  ),
                ),
              ),
              child: const Text("Buy Now"),
            )
          ],
        ),
      ),
    );
  }
}
