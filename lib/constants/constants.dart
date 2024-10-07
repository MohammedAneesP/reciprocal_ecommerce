import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/presentation/address_checkout/widgets/pay_success.dart';


void showPaymentSuccessDialog(BuildContext context) {
  final screenSize = MediaQuery.of(context).size.height;
  double anSize = screenSize < 750 ? 13 : 17;
  final kBlueText =
      TextStyle(color: kBlue, fontSize: anSize, fontWeight: FontWeight.w500);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Purchase Successful!'),
        content: const PaymentSuccessWidget(),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Continue shopping', style: kBlueText),
          ),
        ],
      );
    },
  );
}
