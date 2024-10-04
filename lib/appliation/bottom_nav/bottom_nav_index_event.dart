part of 'bottom_nav_index_bloc.dart';

@immutable
sealed class BottomNavIndexEvent {}

class ChangeIndex extends BottomNavIndexEvent{
  final int anIndex;
  ChangeIndex({required this.anIndex});
}
