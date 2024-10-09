import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciprocal_task/appliation/cart_listing/cart_listing_bloc.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/domain/models/product_model.dart';
import 'package:reciprocal_task/presentation/cart/widgets/cart_bottom.dart';
import 'package:reciprocal_task/presentation/cart/widgets/cart_decrement.dart';
import 'package:reciprocal_task/presentation/cart/widgets/cart_increment.dart';
import 'package:reciprocal_task/presentation/cart/widgets/no_product_view.dart';
import 'package:reciprocal_task/presentation/cart/widgets/cart_image.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final firename = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> toSaveIn = {};
  ValueNotifier<int> totalPrice = ValueNotifier(0);
  List<ValueNotifier<int>> listOfPrices = [];

  void fetchCart(BuildContext context) {
    if (firename != null) {
      BlocProvider.of<CartListingBloc>(context)
          .add(JustShowCart(anEmail: firename!.email.toString()));
    }
  }

  void updateTotalPrice() {
    // Reset total price to 0 and then calculate based on current price of product as per count
    int sum = 0;
    for (var priceNotifier in listOfPrices) {
      sum += priceNotifier.value;
    }
    totalPrice.value = sum;
  }

  void listOfPricesinitialValues({required List<dynamic> anList}) {
    for (var i = 0; i < anList.length; i++) {
      double thePrices = anList[i].price;
      listOfPrices.add(ValueNotifier(thePrices.toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kheight = MediaQuery.sizeOf(context);
    fetchCart(context);
    return BlocBuilder<CartListingBloc, CartListingState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const NoProductInCart();
        } else if (state is ShowCart) {
          if (state.cartProducts.isEmpty) {
            return const Center(child: NoProductInCart());
          } else {
            for (var element in state.cartProducts) {
              Products toAdd = Products(
                  id: element.id,
                  title: element.title,
                  price: element.price,
                  description: element.description,
                  category: element.category,
                  image: element.image,
                  rating: element.rating);
              toSaveIn[element.id.toString()] = toAdd.toJson();
            }

            listOfPricesinitialValues(anList: state.cartProducts);

            updateTotalPrice();
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_outlined)),
                centerTitle: true,
                title: const Text(
                  "CART",
                  style: kTitleText,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: kheight.height * .8,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      double thePrice = state.cartProducts[index].price;
                      ValueNotifier<int> anQuatity = ValueNotifier(1);
                      ValueNotifier<int> anProductPrice =
                          ValueNotifier(thePrice.toInt());
                      toSaveIn[state.cartProducts[index].id.toString()]
                          ["item count"] = anQuatity.value.toString();

                      return SizedBox(
                        height: kheight.height * 0.2,
                        child: Row(
                          children: [
                            CartImage(
                              kHeight: kheight,
                              kWidth: kheight,
                              theUrl: state.cartProducts[index].image,
                            ),
                            SizedBox(width: kheight.width * 0.03),
                            SizedBox(
                              height: kheight.height * 0.2,
                              width: kheight.width * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.cartProducts[index].category),
                                    ValueListenableBuilder(
                                      valueListenable: anQuatity,
                                      builder: (context, value, child) {
                                        return Text(
                                            "\$ ${anProductPrice.value * anQuatity.value} ");
                                      },
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (anQuatity.value > 1 &&
                                                anQuatity.value < 31) {
                                              anQuatity.value -= 1;
                                              double anAmount = state
                                                  .cartProducts[index].price;
                                              listOfPrices[index].value =
                                                  (anQuatity.value) *
                                                      anAmount.toInt();

                                              updateTotalPrice();
                                              toSaveIn[state
                                                          .cartProducts[index].id
                                                          .toString()]
                                                      ["item count"] =
                                                  anQuatity.value.toString();
                                            }
                                          },
                                          child: CartReduceIcon(
                                              kWidth: kheight,
                                              kHeight: kheight),
                                        ),
                                        SizedBox(width: kheight.width * 0.03),
                                        ValueListenableBuilder(
                                          valueListenable: anQuatity,
                                          builder: (context, value, child) {
                                            return Text(
                                                anQuatity.value.toString());
                                          },
                                        ),
                                        SizedBox(width: kheight.width * 0.03),
                                        GestureDetector(
                                          onTap: () {
                                            if (anQuatity.value < 30) {
                                              anQuatity.value += 1;
                                              double anAmount = state
                                                  .cartProducts[index].price;
                                              listOfPrices[index].value =
                                                  (anQuatity.value) *
                                                      anAmount.toInt();

                                              updateTotalPrice();
                                              toSaveIn[state
                                                          .cartProducts[index].id
                                                          .toString()]
                                                      ["item count"] =
                                                  anQuatity.value.toString();
                                            }
                                          },
                                          child: CartAddIcon(
                                              kWidth: kheight,
                                              kHeight: kheight),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("no")),
                                        TextButton(
                                            onPressed: () {
                                              BlocProvider.of<CartListingBloc>(
                                                      context)
                                                  .add(
                                                CartRemoveItem(
                                                  anEmail: firename!.email
                                                      .toString(),
                                                  productId: state
                                                      .cartProducts[index].id
                                                      .toString(),
                                                ),
                                              );
                                              BlocProvider.of<CartListingBloc>(
                                                      context)
                                                  .add(
                                                JustShowCart(
                                                    anEmail: firename!.email
                                                        .toString()),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Yes"))
                                      ],
                                      content: const Text(
                                          "Do you wann't to remove this item"),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: kTransparent,
                    ),
                    itemCount: state.cartProducts.length,
                  ),
                ),
              ),
              bottomSheet: CartBottomSheet(
                  kheight: kheight, totalPrice: totalPrice, toSaveIn: toSaveIn),
            );
          }
        } else {
          return const Center(child: NoProductInCart());
        }
      },
    );
  }
}
