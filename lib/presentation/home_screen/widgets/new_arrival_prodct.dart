import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';

class NewArrivalProduct extends StatelessWidget {
  const NewArrivalProduct({
    super.key,
    required this.product,
    required this.productName,
  });

  final dynamic product;
  final String productName;

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    final screenSize = MediaQuery.of(context).size.height;
    double blueSize = screenSize < 750 ? 15 : 17;
    double titleSize = screenSize < 750 ? 18 : 22;
    double noBoldSize = screenSize < 750 ? 17 : 20;
    final kBlueText = TextStyle(
        color: kBlue, fontSize: blueSize, fontWeight: FontWeight.w500);
    final kTitleText = TextStyle(
        fontWeight: FontWeight.bold, fontSize: titleSize, color: kBlack);
    final kNonBoldBigText = TextStyle(
        fontWeight: FontWeight.w500, fontSize: noBoldSize, color: kBlack);
    return Container(
      height: kHeight.height * 0.2,
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: kHeight.height * 0.8,
            width: kWidth.width * 0.55,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kHeight.height * 0.036),
                 
                  const SizedBox(height: 5),
                  Text(productName, style: kTitleText),
                  const SizedBox(height: 5),
                  Text("\$ ${product.price}", style: kNonBoldBigText)
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Transform.flip(
                  flipX: true,
                  child: Transform.rotate(
                    angle: pi / 12.5,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      placeholder: (context, url) =>
                        const  Center(child:  CircularProgressIndicator()),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: kHeight.height * 0.17,
                          width: kWidth.width * .35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
