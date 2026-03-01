// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ejar/features/addProduct/presentation/models/add_propirity_model.dart';
import 'package:ejar/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_propirity_state.dart';

class AddPropirityCubit extends Cubit<AddPropirityState> {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String imagePath = '';
  AddPropirityCubit() : super(AddPropirityInitial());
  Future<void> storeImg({required File img}) async {
    try {
      emit(AddPropirityLoading());

      // الحل الهندسي: اسم ملف فريد مع امتداد
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      // تأكد من تطابق الاسم 'propirity_images' مع سوبابيز بالحرف
      await supabase.storage
          .from('propirity_images')
          .upload(
            fileName,
            img,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      imagePath = supabase.storage
          .from('propirity_images')
          .getPublicUrl(fileName);

      if (!isClosed) emit(AddPropirityInitial());
    } catch (e) {
      // اطبع الـ Error كامل عشان لو فيه تفاصيل تانية تظهرلنا
      debugPrint("Storage Error Detail: $e");
      if (!isClosed) emit(AddPropirityFailure(e.toString()));
    }
  }

  Future<void> addPropirity() async {
    try {
      emit(AddPropirityLoading());
      final currentUser = supabase.auth.currentUser;
      if (currentUser != null) {
        final propirity = AddPropirityModel(
          user_id: currentUser.id,
          title: titleController.text,
          location: locationController.text,
          price_per_month: priceController.text,
          img_url: imagePath,
          description: descriptionController.text,
        );
        await supabase.from('properties').insert(propirity.toMap());
        emit(AddPropiritySuccess());
      }
    } on AuthException catch (e) {
      emit(AddPropirityFailure(e.message));
    } catch (e) {
      emit(AddPropirityFailure(e.toString()));
    }
  }
}
