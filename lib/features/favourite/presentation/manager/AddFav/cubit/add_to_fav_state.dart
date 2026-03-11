part of 'add_to_fav_cubit.dart';

@immutable
sealed class AddToFavState {}

final class AddToFavInitial extends AddToFavState {}

final class AddToFavLoading extends AddToFavState {}

final class AddToFavSuccess extends AddToFavState {}

final class AddToFavFailure extends AddToFavState {
  final String message;
  AddToFavFailure(this.message);
}
