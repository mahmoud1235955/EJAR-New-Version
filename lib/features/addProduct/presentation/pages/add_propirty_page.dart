import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/core/routes/app_routes.dart';
import 'package:ejar/core/routes/custom_auth_field.dart';
import 'package:ejar/features/addProduct/presentation/manager/propirity/cubit/add_propirity_cubit.dart';
import 'package:ejar/features/addProduct/presentation/manager/uploadImg/cubit/upload_img_cubit.dart';
import 'package:ejar/features/addProduct/presentation/widgets/custom_upload_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPropertyPage extends StatelessWidget {
  const AddPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddPropirityCubit()),
        BlocProvider(create: (context) => UploadImgCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Add New Property")),
        body: BlocConsumer<AddPropirityCubit, AddPropirityState>(
          listener: (context, state) {
            if (state is AddPropiritySuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            } else if (state is AddPropirityFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddPropirityCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BlocBuilder<UploadImgCubit, UploadImgState>(
                    builder: (context, state) {
                      final imgCubit = context.read<UploadImgCubit>();
                      return CustomUploadImage(
                        state: state,
                        onTap: () async {
                          await imgCubit.pickImg();
                          await cubit.storeImg(img: imgCubit.image!);
                        },
                      );
                    },
                  ), // ويدجت لرفع الصور
                  20.gap,
                  CustomAuthField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: cubit.titleController,
                    label: "Property Title",
                    icon: Icons.home,
                  ),
                  15.gap,
                  CustomAuthField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: cubit.locationController,
                    label: "Location",
                    icon: Icons.location_on,
                  ),
                  15.gap,
                  CustomAuthField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    controller: cubit.priceController,
                    label: "Monthly Rent (EGP)",
                    icon: Icons.money,
                  ),
                  15.gap,
                  CustomAuthField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: cubit.locationController,
                    label: "Location",
                    icon: Icons.location_city,
                  ),
                  15.gap,
                  CustomAuthField(
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    controller: cubit.locationController,
                    label: "Description",
                    icon: Icons.description,
                  ),
                  30.gap,
                  ElevatedButton(
                    onPressed: state is AddPropirityLoading
                        ? null
                        : () async {
                            print(cubit.imagePath);
                            // التحقق من البيانات (Validation)
                            if (cubit.imagePath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Upload image first"),
                                ),
                              );
                              return;
                            }
                            await cubit.addPropirity();
                          },
                    child: state is AddPropirityLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text("Post Property"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
