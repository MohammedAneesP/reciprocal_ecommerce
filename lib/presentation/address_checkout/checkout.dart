import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/constants.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/presentation/address_checkout/widgets/address_textform.dart';
import 'package:reciprocal_task/presentation/bottom_nav/bottom_nav.dart';
import 'package:reciprocal_task/repositories/to_order/orders_adding.dart';

class Checkout extends StatelessWidget {
  final Map<String, dynamic> products;
  final int totalCost;
  Checkout({super.key, required this.products, required this.totalCost});

  final firename = FirebaseAuth.instance.currentUser;
  final Map<String, dynamic> toOrders = {};

  final GlobalKey<FormState> anFormKey = GlobalKey<FormState>();
  final TextEditingController anEmailEditingController =
      TextEditingController();
  final TextEditingController numberEditingController = TextEditingController();
  final TextEditingController addressEditingController =
      TextEditingController();

  void addingCheckOutDetails() {
    products.forEach(
      (key, value) {
        log(value.toString());
        final anTime = DateTime.now().toString();
        value["date and time"] = anTime;
        value["address"] = addressEditingController.text;
        value["number"] = numberEditingController.text.toString();
        value["checkout email"] = anEmailEditingController.text;
      },
    );
    toOrders["email"] = firename!.email.toString();
    toOrders["products"] = products;
  }

  @override
  Widget build(BuildContext context) {
    // log(products.toString());
    // addingCheckOutDetails();
    final kheight = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentScope = FocusScope.of(context);

        if (!currentScope.hasPrimaryFocus) {
          currentScope.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("CHECKOUT", style: kTitleText),
          centerTitle: true,
          surfaceTintColor: kTransparent,
          backgroundColor: kGrey200,
          shadowColor: kTransparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: anFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Contact information :", style: kHeadingMedText),
                  const SizedBox(height: 5),
                  AddressTextForm(
                    anEmailEditingController: anEmailEditingController,
                    returnText: "please fill this",
                    anLabelText: "Email",
                    isObscure: false,
                    anPrefixIcon: const Icon(Icons.email),
                    keyInputType: TextInputType.emailAddress,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 15),
                  AddressTextForm(
                    anEmailEditingController: numberEditingController,
                    returnText: "please fill number",
                    anLabelText: "Number",
                    isObscure: false,
                    anPrefixIcon: const Icon(Icons.call),
                    keyInputType: TextInputType.number,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 15),
                  AddressTextForm(
                      anEmailEditingController: addressEditingController,
                      returnText: "please fill address",
                      anLabelText: "address",
                      isObscure: false,
                      anPrefixIcon: const Icon(Icons.home),
                      keyInputType: TextInputType.name,
                      maxLines: 3),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: SizedBox(
          height: kheight.height * 0.15,
          width: kheight.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Cost", style: kTitleNonBoldText),
                    Text(
                      totalCost.toString(),
                      style: kTitleNonBoldText,
                    )
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (anFormKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    addingCheckOutDetails();
                                    log(products.toString());

                                    await AddingeOrders().addingorders(
                                        anMap: toOrders,
                                        anEmail: firename!.email.toString());
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    if (context.mounted) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNav()));
                                      showPaymentSuccessDialog(context);
                                    }
                                  },
                                  child: const Text(
                                    "yes",
                                    style: kSubTextNonBold,
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("no")),
                            ],
                            title: const Text("Are you ready to pay..?"),
                            content: const Text("Are you sure.. "),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          );
                        },
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.amberAccent),
                    minimumSize: WidgetStatePropertyAll(
                      Size(
                        kheight.width,
                        kheight.height * 0.07,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: buttontextBlack,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
