import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'recive_fav_state.dart';

class ReciveFavCubit extends Cubit<ReciveFavState> {
  SupabaseClient supabase = Supabase.instance.client;
  ReciveFavCubit() : super(ReciveFavInitial());
  void reciveFav() {
    try {
      emit(ReciveFavLoading());

      supabase
          .from("favorites")
          .stream(primaryKey: ["id"])
          .eq("user_id", supabase.auth.currentUser!.id)
          .listen(
            (data) {
              emit(ReciveFavSuccess(favorites: data));
            },
            onError: (error) {
              // هنا بنمسك الـ Timeout ونظهره للمستخدم بدل ما الأبلكيشن يضرب
              print("Realtime Error: $error");
              emit(
                ReciveFavFailure(
                  message: "خطأ في الاتصال بالسيرفر، جرب مرة أخرى",
                ),
              );
            },
          );
    } catch (e) {
      emit(ReciveFavFailure(message: e.toString()));
    }
  }

  Future<void> deleteFav() async {
    try {
      emit(ReciveFavLoading());
      await supabase.from("favorites").delete();
      emit(DeleteFavSuccess());
    } on AuthException catch (e) {
      emit(ReciveFavFailure(message: e.message));
    } catch (e) {
      emit(ReciveFavFailure(message: e.toString()));
    }
  }
}
