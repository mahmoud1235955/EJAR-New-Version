// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final supabase = Supabase.instance.client;
  bool isPasswordVisible = false;
  SignupCubit() : super(SignupInitial());

  Future<void> signup(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    emit(SignupLoading());
    try {
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final String? userId = response.user?.id;
      if (userId != null) {
        await supabase.from("profiles").insert({
          "id": userId,
          "full_name": name,
          "phone": phone,
          "password": password,
          "email": email,
          "user_id": userId,
          "bio": "",
        });
      }
      emit(SignupSuccess());
    } on AuthException catch (e) {
      emit(SignupFailure(e.message));
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignupInitial());
  }
}
