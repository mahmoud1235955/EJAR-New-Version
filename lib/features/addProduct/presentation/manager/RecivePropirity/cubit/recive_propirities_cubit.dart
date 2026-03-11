import 'package:bloc/bloc.dart';
import 'package:ejar/features/addProduct/presentation/models/add_propirity_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'recive_propirities_state.dart';

class RecivePropiritiesCubit extends Cubit<RecivePropiritiesState> {
  RecivePropiritiesCubit() : super(RecivePropiritiesInitial());
  List<AddPropirityModel> propirities = [];
  SupabaseClient supabase = Supabase.instance.client;
  void getPropirities() {
    try {
      emit(RecivePropiritiesLoading());
      final stream = supabase
          .from("properties")
          .stream(primaryKey: ["id"])
          .neq("user_id", supabase.auth.currentUser!.id);
      stream.listen((List<Map<String, dynamic>> data) {
        propirities = data.map((e) => AddPropirityModel.fromMap(e)).toList();
        emit(RecivePropiritiesSuccess(propirities: List.from(propirities)));
      });
    } on AuthException catch (e) {
      emit(RecivePropiritiesFailure(message: e.message));
    } catch (e) {
      emit(RecivePropiritiesFailure(message: e.toString()));
    }
  }
}
