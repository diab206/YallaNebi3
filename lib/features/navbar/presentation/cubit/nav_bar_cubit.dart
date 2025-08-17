import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  int currentIndex = 0;
  NavBarCubit() : super(NavBarInitial());
  void changeIndex(int index) {
    currentIndex = index;
    emit(IndexChanged());
  }
}
