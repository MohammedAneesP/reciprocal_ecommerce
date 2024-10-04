import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';

import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/presentation/product_view/widgets/pop_back.dart';
import 'package:reciprocal_task/repositories/to_cart_firebase/adding_tocart.dart';

class ProductView extends StatelessWidget {
  final dynamic anProduct;
  ProductView({super.key, required this.anProduct});

  final firename = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final kheight = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
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
            ),
            Expanded(
                child: Container(
              width: kheight.width,
              decoration: BoxDecoration(
                  color: kGrey200,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: kheight.height * 0.03),
                    Text("${anProduct.category}", style: kBlueThinText),
                    SizedBox(height: kheight.height * 0.02),
                    Text(
                      "\$ ${anProduct.price}",
                      style: kHeadingMedText,
                    ),
                    SizedBox(height: kheight.height * 0.02),
                    Text(anProduct.title, style: kHeadingText),
                    SizedBox(height: kheight.height * 0.03),
                    Text(
                      anProduct.description,
                      style: kGreySmallText,
                      maxLines: 100,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SizedBox(
                          height: kheight.height * 0.1,
                          width: kheight.width * 0.215,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text("Price", style: kGreyItalicText),
                              Text("\$${anProduct.price}", style: kTitleText),
                              const Spacer(),
                            ],
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            await AddingTocart().addTocart(
                                product: anProduct,
                                anEmail: firename!.email.toString(),
                                productId: anProduct.id.toString());
                          },
                          style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(
                                Colors.amberAccent),
                            minimumSize: WidgetStatePropertyAll(
                              Size(
                                kheight.width * 0.5,
                                kheight.height * 0.075,
                              ),
                            ),
                          ),
                          child: const Text("Add to cart"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
