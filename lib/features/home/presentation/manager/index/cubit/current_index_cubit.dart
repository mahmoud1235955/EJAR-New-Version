import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_index_state.dart';

class CurrentIndexCubit extends Cubit<CurrentIndexState> {
  int index = 0;
  CurrentIndexCubit() : super(CurrentIndexInitial());

  void changeIndex(int newIndex) {
    index = newIndex;
    emit(CurrentIndexChanged(index: index));
  }
}
