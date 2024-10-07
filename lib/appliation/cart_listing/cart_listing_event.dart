part of 'cart_listing_bloc.dart';

@immutable
sealed class CartListingEvent {}

class FetchCart extends CartListingEvent {
  final String anEmail;

  FetchCart({required this.anEmail});
}

class JustShowCart extends CartListingEvent {
  final String anEmail;

  JustShowCart({required this.anEmail});
}

class CartRemoveItem extends CartListingEvent {
  final String anEmail;
  final String productId;

  CartRemoveItem({required this.anEmail, required this.productId});
}


