import 'package:bloc/bloc.dart';
import 'package:ejar/features/addProduct/presentation/models/add_car_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'recive_cars_state.dart';

class ReciveCarsCubit extends Cubit<ReciveCarsState> {
  ReciveCarsCubit() : super(ReciveCarsInitial());
  List<AddCarModel> cars = [];
  SupabaseClient supabase = Supabase.instance.client;
  void getCars() {
    try {
      emit(ReciveCarsLoading());
      final stream = supabase
          .from("cars")
          .stream(primaryKey: ["id"])
          .eq("user_id", supabase.auth.currentUser!.id);
      stream.listen((List<Map<String, dynamic>> data) {
        cars = data.map((e) => AddCarModel.fromMap(e)).toList();
      });
      emit(ReciveCarsSuccess(cars: List.from(cars)));
    } on AuthException catch (e) {
      emit(ReciveCarsFailure(message: e.message));
    } catch (e) {
      emit(ReciveCarsFailure(message: e.toString()));
    }
  }
}
