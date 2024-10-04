import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_index_event.dart';
part 'bottom_nav_index_state.dart';

class BottomNavIndexBloc
    extends Bloc<BottomNavIndexEvent, BottomNavIndexState> {
  BottomNavIndexBloc() : super(TheIndex(currentIndex: 0)) {
    on<ChangeIndex>((event, emit) {
      return emit(TheIndex(currentIndex: event.anIndex));
    });
  }
}
