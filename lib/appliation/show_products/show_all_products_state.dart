part of 'show_all_products_bloc.dart';

@immutable
sealed class ShowAllProductsState {}

final class ShowAllProductsInitial extends ShowAllProductsState {}

class LoadingState extends ShowAllProductsState {}

class ShowFullProducts extends ShowAllProductsState {
  final List<dynamic> fullProducts;

  ShowFullProducts({required this.fullProducts});
}
