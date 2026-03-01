part of 'recive_bikes_cubit.dart';

@immutable
sealed class ReciveBikesState {}

final class ReciveBikesInitial extends ReciveBikesState {}

final class ReciveBikesLoading extends ReciveBikesState {}

final class ReciveBikesSuccess extends ReciveBikesState {
  final List<AddBikeModel> bikes;
  ReciveBikesSuccess({required this.bikes});
}

final class ReciveBikesFailure extends ReciveBikesState {
  final String message;
  ReciveBikesFailure({required this.message});
}
