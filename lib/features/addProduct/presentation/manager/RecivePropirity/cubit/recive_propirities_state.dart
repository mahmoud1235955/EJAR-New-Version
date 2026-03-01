part of 'recive_propirities_cubit.dart';

@immutable
sealed class RecivePropiritiesState {}

final class RecivePropiritiesInitial extends RecivePropiritiesState {}

final class RecivePropiritiesLoading extends RecivePropiritiesState {}

final class RecivePropiritiesSuccess extends RecivePropiritiesState {
  final List<AddPropirityModel> propirities;
  RecivePropiritiesSuccess({required this.propirities});
}

final class RecivePropiritiesFailure extends RecivePropiritiesState {
  final String message;
  RecivePropiritiesFailure({required this.message});
}
