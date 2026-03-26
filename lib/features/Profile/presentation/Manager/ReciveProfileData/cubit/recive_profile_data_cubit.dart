import 'package:bloc/bloc.dart';
import 'package:ejar/features/Profile/presentation/Manager/ReciveProfileData/models/recive_profile_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'recive_profile_data_state.dart';

class ReciveProfileDataCubit extends Cubit<ReciveProfileDataState> {
  static SupabaseClient supabase = Supabase.instance.client;
  ReciveProfileDataCubit() : super(ReciveProfileDataInitial());

  Future<void> getProfileData() async {
    try {
      emit(ReciveProfileDataLoading());
      final data = await supabase
          .from("profiles")
          .select()
          .eq("id", supabase.auth.currentUser!.id)
          .single();
          if (isClosed) return;
      emit(
        ReciveProfileDataSuccess(profile: ReciveProfileModel.fromJson(data)),
      );
    } on AuthException catch (e) {
      emit(ReciveProfileDataError(message: e.message));
    } catch (e) {
      emit(ReciveProfileDataError(message: e.toString()));
    }
  }
}
