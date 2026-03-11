// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ejar/features/addProduct/presentation/models/add_bike_model.dart';
import 'package:ejar/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_bike_state.dart';

class AddBikeCubit extends Cubit<AddBikeState> {
  TextEditingController type = TextEditingController();
  TextEditingController user_id = TextEditingController();
  TextEditingController price_per_day = TextEditingController();
  TextEditingController descripttion = TextEditingController();
  TextEditingController location = TextEditingController();
  String image_url = '';
  AddBikeCubit() : super(AddBikeInitial());
  Future<void> storeImg({required File img}) async {
    try {
      emit(AddBikeLoading());
      final int randomNumber = Random().nextInt(1000000);
      await supabase.storage
          .from('bike_images')
          .upload(randomNumber.toString(), img);
      image_url = supabase.storage
          .from('bike_images')
          .getPublicUrl(randomNumber.toString());
      emit(AddBikeInitial());
    } on AuthException catch (e) {
      emit(AddBikeFailure(e.message));
    } catch (e) {
      emit(AddBikeFailure(e.toString()));
    }
  }

  Future<void> addBike() async {
    final currentUser = supabase.auth.currentUser;
    try {
      if (currentUser != null) {
        final bike = AddBikeModel(
          descripttion: descripttion.text,
          name: type.text,
          price_per_day: price_per_day.text,
          image_url: image_url,
          location: location.text,
          user_id: currentUser.id,
        );
        await supabase.from('bikes').insert(bike.toMap());
        emit(AddBikeSuccess());
      }
    } on AuthException catch (e) {
      emit(AddBikeFailure(e.message));
    } catch (e) {
      emit(AddBikeFailure(e.toString()));
    }
  }
}
