import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:reciprocal_task/domain/models/product_model.dart';

part 'cart_listing_event.dart';
part 'cart_listing_state.dart';

class CartListingBloc extends Bloc<CartListingEvent, CartListingState> {
  CartListingBloc() : super(CartListingInitial()) {
    on<FetchCart>((event, emit) async {
      try {
        final anValues = await FirebaseFirestore.instance
            .collection("cart")
            .doc(event.anEmail)
            .get();
        if (anValues.exists) {
          final theData = anValues.data();
          if (theData!.isEmpty) {
            return emit(GetCart(
                cartProducts: const {}, errorMessage: "nothing in the cart"));
          } else {
            return emit(GetCart(cartProducts: theData, errorMessage: ""));
          }
        } else {
          return emit(GetCart(
              cartProducts: const {}, errorMessage: "nothing in the cart"));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<JustShowCart>(
      (event, emit) async {
        try {
          final anValues = await FirebaseFirestore.instance
              .collection("cart")
              .doc(event.anEmail)
              .get();
          if (anValues.exists) {
            final theData = anValues.data();
            if (theData!.isEmpty) {
              return emit(ShowCart(
                  cartProducts: const [], errorMessage: "nothing in the cart"));
            } else {
              List<Products> productList = theData.entries
                  .map((element) => Products.fromJson(element.value))
                  .toList();

              return emit(
                  ShowCart(cartProducts: productList, errorMessage: ""));
            }
          } else {
            return emit(ShowCart(
                cartProducts: const [], errorMessage: "nothing in the cart"));
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );

    on<CartRemoveItem>(
      (event, emit) async {
        try {
          final anValues = await FirebaseFirestore.instance
              .collection("cart")
              .doc(event.anEmail)
              .get();
          if (anValues.exists) {
            final anDatas = anValues.data();
            if (anDatas!.isEmpty) {
              return emit(ShowCart(
                  errorMessage: "errorMessage", cartProducts: const []));
            }

            anDatas.remove(event.productId.toString());
            await FirebaseFirestore.instance
                .collection("cart")
                .doc(event.anEmail)
                .set(anDatas);

            List<Products> productList = anDatas.entries
                .map((element) => Products.fromJson(element.value))
                .toList();

            return emit(ShowCart(errorMessage: "", cartProducts: productList));
          }
          return emit(
              ShowCart(errorMessage: "errorMessage", cartProducts: const []));
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }
}
