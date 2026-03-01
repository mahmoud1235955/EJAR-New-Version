part of 'buttons_index_cubit.dart';

@immutable
sealed class ButtonsIndexState {}

final class ButtonsIndexInitial extends ButtonsIndexState {}

final class ButtonsIndexSuccess extends ButtonsIndexState {
  final int buttonIndex;
  final int pageViewIndex;
  ButtonsIndexSuccess({required this.buttonIndex, required this.pageViewIndex});
}
