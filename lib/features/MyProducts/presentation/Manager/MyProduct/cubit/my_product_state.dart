part of 'my_product_cubit.dart';

@immutable
sealed class MyProductState {}

final class MyProductInitial extends MyProductState {}

final class MyProductLoading extends MyProductState {}

final class MyProductSuccess extends MyProductState {
  final List<MyproductModel> products;
  MyProductSuccess({required this.products});
}

final class MyProductError extends MyProductState {
  final String message;
  MyProductError({required this.message});
}
