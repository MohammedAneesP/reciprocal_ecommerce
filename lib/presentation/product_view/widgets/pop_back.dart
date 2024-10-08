import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';

class PopBackButton extends StatelessWidget {
  const PopBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: kWhite,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back)),
      ),
    );
  }
}
