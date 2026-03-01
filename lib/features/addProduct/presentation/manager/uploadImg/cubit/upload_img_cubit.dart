// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'upload_img_state.dart';

class UploadImgCubit extends Cubit<UploadImgState> {
  File? image;
  final ImagePicker picker = ImagePicker();
  UploadImgCubit() : super(UploadImgInitial());
  Future<void> pickImg() async {
    try {
      if (isClosed) return;
      final XFile? selectedImg = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (selectedImg != null) {
        image = File(selectedImg.path);
        if (!isClosed) emit(UploadImgSuccess(img: image!));
      } else {
        // لو لغى الاختيار نرجعه للحالة الابتدائية بدل ما نضرب Error
        if (!isClosed) emit(UploadImgInitial());
      }
    } catch (e) {
      if (!isClosed) emit(UploadImgFailure(e.toString()));
    }
  }
}
