import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciprocal_task/appliation/cart_listing/cart_listing_bloc.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/presentation/product_view/widgets/go_to_cart.dart';
import 'package:reciprocal_task/presentation/product_view/widgets/image_section.dart';
import 'package:reciprocal_task/presentation/product_view/widgets/not_logged_button.dart';
import 'package:reciprocal_task/repositories/to_cart_firebase/adding_tocart.dart';

class ProductView extends StatelessWidget {
  final dynamic anProduct;
   ProductView({super.key, required this.anProduct});

  final firename = FirebaseAuth.instance.currentUser;

  void callingBloc(BuildContext context) {
    if (firename != null) {
      BlocProvider.of<CartListingBloc>(context)
          .add(FetchCart(anEmail: firename!.email.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    callingBloc(context);
    final kheight = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(anProduct: anProduct, kheight: kheight),
              Container(
                width: kheight.width,
                height: kheight.height * .7,
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
                      Text("${anProduct.category}",
                          style: kBlueThinText),
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
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          SizedBox(
            height: kheight.height * 0.1,
            width: kheight.width * 0.215,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text("Price", style: kGreyItalicText),
                Text("\$${anProduct.price}", style: kTitleText),
                const Spacer(),
              ],
            ),
          ),
          const Spacer(),
          firename == null
              ? NotLoggedInButton(kheight: kheight)
              : BlocBuilder<CartListingBloc, CartListingState>(
                  builder: (context, state) {
                    if (state is GetCart) {
                      if (state.cartProducts
                          .containsKey(anProduct.id.toString())) {
                        return GotoCartButton(kheight: kheight);
                      } else {
                        return ElevatedButton(
                          onPressed: () async {
                            await AddingTocart().addTocart(
                                product: anProduct,
                                anEmail: firename!.email.toString(),
                                productId: anProduct.id.toString());
                            if (context.mounted) {
                              BlocProvider.of<CartListingBloc>(context).add(
                                  FetchCart(
                                      anEmail: firename!.email.toString()));
                            }
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
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
