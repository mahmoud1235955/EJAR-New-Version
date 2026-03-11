import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'buttons_index_state.dart';

class ButtonsIndexCubit extends Cubit<ButtonsIndexState> {
  int buttonIndex = 0;
  int pageViewIndex = 0;
  // الـ Controller بيفضل ثابت
  final PageController pageviewController = PageController(initialPage: 0);
  Timer? timer;

  ButtonsIndexCubit() : super(ButtonsIndexInitial());

  void changeButtonIndex(int newIndex) {
    buttonIndex = newIndex;
    _emitSuccess();
  }

  void startAutoPlay() {
    // 1. تأمين: لو فيه تايمر شغال اقفله قبل ما تبدأ جديد
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 2), (t) {
      // ثانية واحدة سريعة جداً، خليتها 2 لأداء أفضل
      if (pageViewIndex < 2) {
        pageViewIndex++;
      } else {
        pageViewIndex = 0;
      }

      // 2. تأمين: التأكد إن الـ PageView مرسومة حالياً على الشاشة
      if (pageviewController.hasClients) {
        pageviewController.animateToPage(
          pageViewIndex,
          duration: const Duration(milliseconds: 800), // سرعة الحركة
          curve: Curves.easeInOut,
        );
      }

      _emitSuccess();
    });
  }

  // ميثود مساعدة لتقليل تكرار الكود
  void _emitSuccess() {
    emit(
      ButtonsIndexSuccess(
        buttonIndex: buttonIndex,
        pageViewIndex: pageViewIndex,
      ),
    );
  }

  // 3. أهم جزء للمهندسين: تنظيف الذاكرة
  @override
  Future<void> close() {
    timer?.cancel();
    pageviewController.dispose();
    return super.close();
  }
}
