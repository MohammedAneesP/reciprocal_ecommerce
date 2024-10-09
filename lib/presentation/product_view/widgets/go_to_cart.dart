
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/presentation/cart/cart_screen.dart';

class GotoCartButton extends StatelessWidget {
  const GotoCartButton({
    super.key,
    required this.kheight,
  });

  final Size kheight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CartScreen(),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.amberAccent),
        minimumSize: WidgetStatePropertyAll(
          Size(
            kheight.width * 0.5,
            kheight.height * 0.075,
          ),
        ),
      ),
      child: const Text("Go to cart"),
    );
  }
}
