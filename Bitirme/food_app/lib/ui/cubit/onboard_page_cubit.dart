import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardCubit extends Cubit<int> {
  OnboardCubit() : super(0);

  void nextPage() {
    if (state < 4) {
      emit(state + 1);
    }
  }

  void previousPage() {
    if (state > 0) {
      emit(state - 1);
    }
  }
}
