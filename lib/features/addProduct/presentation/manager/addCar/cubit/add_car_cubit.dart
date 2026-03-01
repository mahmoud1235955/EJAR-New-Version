// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ejar/features/addProduct/presentation/models/add_car_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  final supabase = Supabase.instance.client;
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController transmissionController = TextEditingController();
  TextEditingController descripttionController = TextEditingController();
  TextEditingController price_per_dayController = TextEditingController();
  String? imgUrl;

  AddCarCubit() : super(AddCarLoading());
  Future<void> storeImg({required File img}) async {
    try {
      emit(AddCarLoading());
      final int randomNumber = Random().nextInt(1000000);
      await supabase.storage
          .from('car_images')
          .upload(randomNumber.toString(), img);
      imgUrl = supabase.storage
          .from('car_images')
          .getPublicUrl(randomNumber.toString());
      emit(AddCarSuccess());
    } on AuthException catch (e) {
      emit(AddCarFailure(e.message));
    } catch (e) {
      emit(AddCarFailure(e.toString()));
    }
  }

  Future<void> addCar() async {
    try {
      emit(AddCarLoading());
      final currentUser = supabase.auth.currentUser;
      if (currentUser != null) {
        final car = AddCarModel(
          brand: brandController.text,
          descripttion: descripttionController.text,
          price_per_day: price_per_dayController.text,
          image_url: imgUrl ?? "",
          model: modelController.text,
          year: yearController.text,
          transmission: transmissionController.text,
          user_id: currentUser.id,
        );
        await supabase.from('cars').insert(car.toMap());
      }
      emit(AddCarSuccess());
    } on AuthException catch (e) {
      emit(AddCarFailure(e.message));
    } catch (e) {
      emit(AddCarFailure(e.toString()));
    }
  }

  void clearControllers() {
    modelController.clear();
    yearController.clear();
    transmissionController.clear();
    descripttionController.clear();
    price_per_dayController.clear();
    brandController.clear();
  }
}
