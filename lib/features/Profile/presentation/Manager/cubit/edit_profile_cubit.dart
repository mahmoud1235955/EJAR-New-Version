import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  SupabaseClient supabase = Supabase.instance.client;

  EditProfileCubit() : super(EditProfileInitial());
  Future<void> updateProfile() async {
    try {
      emit(EditProfileLoading());
      await supabase
          .from("profiles")
          .update({
            "full_name": nameController.text,
            "phone": phoneController.text,
            "bio": bioController.text,
            "email": emailController.text,
          })
          .eq("id", supabase.auth.currentUser!.id);
      emit(EditProfileSuccess());
    } on Exception catch (e) {
      emit(EditProfileError(e.toString()));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}
