part of 'bottom_nav_index_bloc.dart';

@immutable
sealed class BottomNavIndexState {}

final class BottomNavIndexInitial extends BottomNavIndexState {}

class TheIndex extends BottomNavIndexState{
  final int currentIndex;
  TheIndex({required this.currentIndex});
}
