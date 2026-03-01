part of 'upload_img_cubit.dart';

@immutable
sealed class UploadImgState {}

final class UploadImgInitial extends UploadImgState {}

final class UploadImgLoading extends UploadImgState {}

final class UploadImgSuccess extends UploadImgState {
  final File img;
  UploadImgSuccess({required this.img});
}

final class UploadImgFailure extends UploadImgState {
  final String message;
  UploadImgFailure(this.message);
}
