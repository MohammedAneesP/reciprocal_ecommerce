import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CartProductImage extends StatelessWidget {
  const CartProductImage({
    super.key,
    required this.anImageUrl,
  });

  final String anImageUrl;

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: true,
      child: Transform.rotate(
        angle: pi / 14,
        child: CachedNetworkImage(
          imageUrl: anImageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageBuilder: (context, imageProvider) {
            return Container(
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
    );
  }
}


