import 'package:flutter/material.dart';

void anSnackBarFunc(
    {required BuildContext context,
    required String aText,
    required Color anColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const StadiumBorder(),
      content: Text(aText),
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      backgroundColor: anColor,
    ),
  );
}

