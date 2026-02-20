// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SupabaseClient supabase = Supabase.instance.client;
  bool isPasswordVisible = false;
  LoginCubit() : super(LoginInitial());
  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Login failed. Please check your credentials."));
      }
    } on AuthException catch (e) {
      emit(LoginFailure(e.message));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginInitial());
  }
}
