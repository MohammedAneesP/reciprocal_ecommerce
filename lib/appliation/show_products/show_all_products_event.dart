part of 'show_all_products_bloc.dart';

@immutable
sealed class ShowAllProductsEvent {}

class GetProductsToShow extends ShowAllProductsEvent{}
