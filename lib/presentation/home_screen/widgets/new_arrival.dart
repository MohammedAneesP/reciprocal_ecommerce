import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';

class NewArrivalText extends StatelessWidget {
  const NewArrivalText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final kHeight = MediaQuery.of(context).size.height;
    double headSize = kHeight < 750 ? 16 : 20;
    final kHeadingText = TextStyle(
    fontWeight: FontWeight.bold, fontSize: headSize, color: kBlack);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 240, 0),
      child: Text(
        "New Arrival",
        style: kHeadingText,
      ),
    );
  }
}