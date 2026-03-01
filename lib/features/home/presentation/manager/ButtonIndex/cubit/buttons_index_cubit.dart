import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'buttons_index_state.dart';

class ButtonsIndexCubit extends Cubit<ButtonsIndexState> {
  int buttonIndex = 0;
  int pageViewIndex = 0;
  ButtonsIndexCubit() : super(ButtonsIndexInitial());

  void changeButtonIndex(int newIndex) {
    buttonIndex = newIndex;
    emit(
      ButtonsIndexSuccess(
        buttonIndex: buttonIndex,
        pageViewIndex: pageViewIndex,
      ),
    );
  }

  void changePageViewIndex(int newIndex) async {
    pageViewIndex = await Future.delayed(
      Duration(seconds: 1),
    ).then((value) => pageViewIndex++);
    pageViewIndex = newIndex;
    emit(
      ButtonsIndexSuccess(
        buttonIndex: buttonIndex,
        pageViewIndex: pageViewIndex,
      ),
    );
  }
}
