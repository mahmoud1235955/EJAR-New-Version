import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  SupabaseClient supabase = Supabase.instance.client;
  LogoutCubit() : super(LogoutInitial());

  void logout() {
    emit(LogoutLoading());
    try {
      supabase.auth.signOut();
    }on Exception catch (e) {
      emit(LogoutFailure(e.toString()));
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
