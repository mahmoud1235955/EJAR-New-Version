part of 'add_bike_cubit.dart';

@immutable
sealed class AddBikeState {}

final class AddBikeInitial extends AddBikeState {}

final class AddBikeLoading extends AddBikeState {}

final class AddBikeSuccess extends AddBikeState {}

final class AddBikeFailure extends AddBikeState {
  final String message;
  AddBikeFailure(this.message);
}
