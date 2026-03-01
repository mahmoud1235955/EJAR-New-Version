import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/core/routes/app_routes.dart';
import 'package:ejar/core/routes/custom_auth_field.dart';
import 'package:ejar/features/addProduct/presentation/manager/addCar/cubit/add_car_cubit.dart';
import 'package:ejar/features/addProduct/presentation/manager/uploadImg/cubit/upload_img_cubit.dart';
import 'package:ejar/features/addProduct/presentation/widgets/custom_upload_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarPage extends StatelessWidget {
  const AddCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddCarCubit()),
        BlocProvider(create: (context) => UploadImgCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Rent Out Your Car")),
        body: BlocConsumer<AddCarCubit, AddCarState>(
          listener: (context, state) {
            if (state is AddCarSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            } else if (state is AddCarFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddCarCubit>();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<UploadImgCubit, UploadImgState>(
                builder: (context, state) {
                  final imgCubit = context.read<UploadImgCubit>();
                  return Column(
                    children: [
                      CustomUploadImage(
                        state: state,
                        onTap: () async {
                          await imgCubit.pickImg();
                          //    await cubit.storeImg(img: imgCubit.image!);
                        },
                      ),
                      20.gap,
                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: cubit.brandController,
                        label: "Car Brand (e.g. BMW)",
                        icon: Icons.directions_car,
                      ),
                      15.gap,
                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: cubit.modelController,
                        label: "Car Model (e.g. X5 2024)",
                        icon: Icons.directions_car,
                      ),
                      15.gap,
                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: cubit.yearController,
                        label: "Production Year",
                        icon: Icons.calendar_today,
                      ),
                      15.gap,
                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: cubit.transmissionController,
                        label: "Transmission (Auto/Manual)",
                        icon: Icons.settings,
                      ),
                      15.gap,
                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: cubit.price_per_dayController,
                        label: "Daily Rent Price",
                        icon: Icons.payments,
                      ),
                      15.gap,
                      CustomAuthField(
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        controller: cubit.descripttionController,
                        label: "Description",
                        icon: Icons.description,
                      ),
                      30.gap,

                      BlocBuilder<UploadImgCubit, UploadImgState>(
                        builder: (uploadContext, uploadState) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: state is UploadImgLoading
                                ? null // بنقفل الزرار لو فيه تحميل شغال
                                : () async {
                                    if (uploadState is UploadImgSuccess) {
                                      // أ. ارفع الصورة واستنى
                                      await cubit.storeImg(
                                        img: uploadState.img,
                                      );
                                      // ب. احفظ البيانات في الجدول واستنى
                                      await cubit.addCar();
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please upload an image first",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                            child: state is UploadImgLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Post Car"),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
