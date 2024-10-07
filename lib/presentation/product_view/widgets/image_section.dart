
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/presentation/product_view/widgets/pop_back.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.anProduct,
    required this.kheight,
  });

  final dynamic anProduct;
  final Size kheight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: anProduct.image,
          placeholder: (context, url) =>
              const CircularProgressIndicator(),
          imageBuilder: (context, imageProvider) {
            return Container(
              height: kheight.height * .4,
              width: kheight.width,
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
        const PopBackButton(),
      ],
    );
  }
}
