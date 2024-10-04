import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reciprocal_task/repositories/api_services/all_products.dart';

part 'show_all_products_event.dart';
part 'show_all_products_state.dart';

class ShowAllProductsBloc
    extends Bloc<ShowAllProductsEvent, ShowAllProductsState> {
  ShowAllProductsBloc() : super(ShowAllProductsInitial()) {
    on<GetProductsToShow>((event, emit) async {
      emit(LoadingState());
      try {
        final products = await AllProducts().fetchAllProducts();
        if (products.isEmpty) {
          return emit(ShowFullProducts(fullProducts: const []));
        } else {
          return emit(ShowFullProducts(fullProducts: products));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
