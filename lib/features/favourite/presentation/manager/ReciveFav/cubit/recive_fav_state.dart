part of 'recive_fav_cubit.dart';

@immutable
sealed class ReciveFavState {}

final class ReciveFavInitial extends ReciveFavState {}

final class ReciveFavLoading extends ReciveFavState {}

final class ReciveFavFailure extends ReciveFavState {
  final String message;
  ReciveFavFailure({required this.message});
}

final class DeleteFavSuccess extends ReciveFavState {}

final class DeleteProductSuccess extends ReciveFavState {}

final class ReciveFavSuccess extends ReciveFavState {
  final List<Map<String, dynamic>> favorites;
  ReciveFavSuccess({required this.favorites});
}
