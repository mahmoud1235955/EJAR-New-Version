// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final SupabaseClient supabase = Supabase.instance.client;
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await supabase.auth.resetPasswordForEmail(email);

      emit(ForgotPasswordSuccess());
    } on AuthException catch (e) {
      emit(ForgotPasswordFailure(e.message));
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
