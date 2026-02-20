part of 'current_index_cubit.dart';

@immutable
sealed class CurrentIndexState {}

final class CurrentIndexInitial extends CurrentIndexState {}

final class CurrentIndexChanged extends CurrentIndexState {
  final int index;
  CurrentIndexChanged({required this.index});
}
