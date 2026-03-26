part of 'toggle_theme_cubit.dart';

@immutable
sealed class ToggleThemeState {}

final class ToggleThemeInitial extends ToggleThemeState {}

final class ToggleThemeSuccess extends ToggleThemeState {
  final bool isDark;
  ToggleThemeSuccess(this.isDark);
}
