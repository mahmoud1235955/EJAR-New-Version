import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart'; // السطر ده هو اللي هيحل كل المشاكل

part 'toggle_theme_state.dart';

// 1. بنورث من HydratedCubit بدل Cubit العادي
class ThemeCubit extends HydratedCubit<ThemeMode> {
  // القيمة الابتدائية هي نظام الجهاز
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme(bool isDark) {
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  // 2. ميثود القراءة من الذاكرة (Deserialization)
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeMode.values[json['theme_index'] as int];
    } catch (_) {
      return ThemeMode.system; // تأمين في حالة وجود خطأ في البيانات
    }
  }

  // 3. ميثود الحفظ في الذاكرة (Serialization)
  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme_index': state.index};
  }
}