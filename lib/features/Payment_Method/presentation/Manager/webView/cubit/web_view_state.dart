part of 'web_view_cubit.dart';

@immutable
sealed class WebViewState {}

final class WebViewInitial extends WebViewState {}

final class WebViewLoading extends WebViewState {}
