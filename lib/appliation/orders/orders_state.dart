part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

class LoadingState extends OrdersState{}

class ShowOrders extends OrdersState {
  final List<dynamic> allorders;


  ShowOrders({required this.allorders});
}
