import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<FetchOrders>((event, emit) async {
      try {
        emit(LoadingState());
        final allDataOrder =
            await FirebaseFirestore.instance.collection("orders").get();
        if (allDataOrder.docs.isEmpty) {
          return emit(ShowOrders(allorders: const []));
        } else {
          List<dynamic> ordersList = [];
          final theOrders = allDataOrder.docs;

          final onlyHisOrders = theOrders
              .where((element) => event.anEmail.contains(element["email"]))
              .toList();

          for (var element in onlyHisOrders.reversed) {
            // log(element.data().keys.toString());

            final value = element.data()["products"] as Map<String, dynamic>;
            
            value.forEach(
              (key, value) {
                ordersList.add(value);
              },
            );
          }
          log(ordersList.toString());
          log(ordersList.length.toString());

          return emit(ShowOrders(allorders: ordersList));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
