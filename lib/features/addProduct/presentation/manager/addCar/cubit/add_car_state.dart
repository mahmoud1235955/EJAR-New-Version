part of 'add_car_cubit.dart';

@immutable
sealed class AddCarState {}

final class AddCarLoading extends AddCarState {}

final class AddCarSuccess extends AddCarState {}

final class AddCarFailure extends AddCarState {
  final String message;

  AddCarFailure(this.message);
}
