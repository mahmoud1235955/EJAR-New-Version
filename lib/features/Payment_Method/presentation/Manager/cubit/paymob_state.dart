part of 'paymob_cubit.dart';

@immutable
sealed class PaymobState {}

final class PaymobInitial extends PaymobState {}

//
final class PaymobAuthLoading extends PaymobState {}

final class PaymobOrderLoading extends PaymobState {}

final class PaymobFinalKeyLoading extends PaymobState {}

final class PaymobSuccess extends PaymobState {
  final String finalToken;
  PaymobSuccess(this.finalToken);
}

final class PaymobError extends PaymobState {
  final String message;
  PaymobError(this.message);
}
