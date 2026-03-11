part of 'recive_profile_data_cubit.dart';

@immutable
sealed class ReciveProfileDataState {}

final class ReciveProfileDataInitial extends ReciveProfileDataState {}

final class ReciveProfileDataLoading extends ReciveProfileDataState {}

final class ReciveProfileDataSuccess extends ReciveProfileDataState {
  final ReciveProfileModel profile;
  ReciveProfileDataSuccess({required this.profile});
}

final class ReciveProfileDataError extends ReciveProfileDataState {
  final String message;
  ReciveProfileDataError({required this.message});
}
