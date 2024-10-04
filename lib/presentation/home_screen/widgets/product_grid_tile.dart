import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    super.key,
    required this.anProductImg,
    required this.textProducts,
    
    
    required this.textPrice,
    required this.imageHeight,
    required this.imageWidth,
    
    required this.anProductId,
    required this.anOnPressed,
  });
  
  
  final double imageHeight;
  final String anProductImg;
  final String textProducts;
  
  final String textPrice;
  final double imageWidth;

  final String anProductId;
  final VoidCallback anOnPressed;

  @override
  Widget build(BuildContext context) {
    final kheight = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: anOnPressed,
      child: Container(
        
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              CachedNetworkImage(
                imageUrl: anProductImg,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: imageHeight,
                    width: imageWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                       SizedBox(height: kheight.height * 0.04),
                      Text(textProducts, style: kHeadingMedText),
                       SizedBox(height: kheight.height * 0.01),
                      Text("₹ $textPrice", style: kSubTitleText),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
