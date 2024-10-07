part of 'cart_listing_bloc.dart';

@immutable
sealed class CartListingState {}

final class CartListingInitial extends CartListingState {}

class LoadingState extends CartListingState {}

class ShowCart extends CartListingState {
  final String errorMessage;
  final List<dynamic> cartProducts;

  ShowCart({required this.errorMessage, required this.cartProducts});
}

class GetCart extends CartListingState {
  final String errorMessage;
  final Map<String, dynamic> cartProducts;

  GetCart({required this.cartProducts, required this.errorMessage});
}
