// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_to_fav_state.dart';

class AddToFavCubit extends Cubit<AddToFavState> {
  SupabaseClient supabase = Supabase.instance.client;
  AddToFavCubit() : super(AddToFavInitial());

  Future<void> addToFav({
    required String category,
    required String product_id,
    required String product_name,
    required String product_price,
    required String product_image,
    required String product_location,
    required String product_description,
  }) async {
    try {
      emit(AddToFavLoading());
      await supabase.from("favorites").insert({
        "user_id": supabase.auth.currentUser!.id,
        "product_id": product_id,
        "category": category,
        "name": product_name,
        "price_per_day": product_price,
        "image_url": product_image,
        "location": product_location,
        "descripttion": product_description,
      });
      emit(AddToFavSuccess());
    } on AuthException catch (e) {
      emit(AddToFavFailure(e.message));
    } catch (e) {
      emit(AddToFavFailure("This product is already in your favorites"));
    }
  }
}
