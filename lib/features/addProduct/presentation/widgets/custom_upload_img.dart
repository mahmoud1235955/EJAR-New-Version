import 'package:ejar/core/colors/app_color.dart';
import 'package:ejar/features/addProduct/presentation/manager/uploadImg/cubit/upload_img_cubit.dart';
import 'package:flutter/material.dart';

class CustomUploadImage extends StatelessWidget {
  // بنعرف متغيرين: واحد للكيوبيت وواحد للأكشن اللي هيتنفذ عند الضغط
  final dynamic state;
  final VoidCallback onTap;

  const CustomUploadImage({
    super.key,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. حالة النجاح (عرض الصورة)
    if (state is UploadImgSuccess) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(state.img, fit: BoxFit.cover),
          ),
        ),
      );
    }

    // 2. حالة التحميل
    if (state is UploadImgLoading) {
      return const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // 3. الحالة الافتراضية (أيقونة الرفع)
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo_outlined,
              size: 50,
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            const Text(
              "Upload Item Photo",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
