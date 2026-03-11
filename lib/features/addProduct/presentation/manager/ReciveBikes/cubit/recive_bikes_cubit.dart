import 'package:bloc/bloc.dart';
import 'package:ejar/features/addProduct/presentation/models/add_bike_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'recive_bikes_state.dart';

class ReciveBikesCubit extends Cubit<ReciveBikesState> {
  ReciveBikesCubit() : super(ReciveBikesInitial());
  List<AddBikeModel> bikes = [];
  SupabaseClient supabase = Supabase.instance.client;
  void getBikes() {
    try {
      emit(ReciveBikesLoading());
      final stream = supabase
          .from("bikes")
          .stream(primaryKey: ["id"])
          .neq("user_id", supabase.auth.currentUser!.id);
      stream.listen((List<Map<String, dynamic>> data) {
        bikes = data.map((e) => AddBikeModel.fromMap(e)).toList();
        print("Data received: ${data.length}"); // حط البرينت ده ضروري للتأكد
        emit(ReciveBikesSuccess(bikes: List.from(bikes)));
      });
    } on AuthException catch (e) {
      emit(ReciveBikesFailure(message: e.message));
    } catch (e) {
      emit(ReciveBikesFailure(message: e.toString()));
    }
  }
}
