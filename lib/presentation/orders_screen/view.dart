import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reciprocal_task/appliation/orders/orders_bloc.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/presentation/orders_screen/widgets/no_orders.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final firename = FirebaseAuth.instance.currentUser;

  void fetchingOrders(BuildContext context) {
    if (firename != null) {
      BlocProvider.of<OrdersBloc>(context)
          .add(FetchOrders(anEmail: firename!.email.toString()));
    }
  }

  List status = ["shipped", "dispatched", "out for Delivery"];

  final random = Random();

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    fetchingOrders(context);
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ShowOrders) {
          if (state.allorders.isEmpty) {
            return NoOrders(kHeight: kHeight);
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("MY ORDERS",style: kTitleText,),
            ),
            body: ListView.separated(
                itemBuilder: (context, index) {
                  final dateAndTime = DateTime.parse(
                      state.allorders[index]["date and time"].toString());
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(dateAndTime);

                  final anStaus = status[random.nextInt(status.length)];

                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: kHeight.height * 0.11,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        // color: kWhite,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: state.allorders[index]["image"],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: kHeight.width * 0.23,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider)),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: kHeight.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.allorders[index]["category"]
                                      .toString(),
                                  style: kTitleText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Ordered in : $formattedDate",
                                    style: kSubTitleText),
                                Text("status : $anStaus",
                                    style: kSubTitleText),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: kHeight.width * 0.1,
                            child: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      color: kTransparent,
                    ),
                itemCount: state.allorders.length),
          );
        }
        return NoOrders(kHeight: kHeight);
      },
    );
  }
}
