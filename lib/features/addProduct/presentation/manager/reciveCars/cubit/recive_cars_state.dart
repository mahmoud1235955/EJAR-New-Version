part of 'recive_cars_cubit.dart';

@immutable
sealed class ReciveCarsState {}

final class ReciveCarsInitial extends ReciveCarsState {}

final class ReciveCarsLoading extends ReciveCarsState {}

final class ReciveCarsSuccess extends ReciveCarsState {
  final List<AddCarModel> cars;
  ReciveCarsSuccess({required this.cars});
}

final class ReciveCarsFailure extends ReciveCarsState {
  final String message;
  ReciveCarsFailure({required this.message});
}
