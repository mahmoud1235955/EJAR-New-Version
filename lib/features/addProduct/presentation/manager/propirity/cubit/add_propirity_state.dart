part of 'add_propirity_cubit.dart';

@immutable
sealed class AddPropirityState {}

final class AddPropirityInitial extends AddPropirityState {}

final class AddPropirityLoading extends AddPropirityState {}

final class AddPropiritySuccess extends AddPropirityState {}

final class AddPropirityFailure extends AddPropirityState {
  final String message;
  AddPropirityFailure(this.message);
}
