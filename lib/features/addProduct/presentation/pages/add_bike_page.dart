import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/core/routes/app_routes.dart';
import 'package:ejar/core/routes/custom_auth_field.dart';
import 'package:ejar/features/addProduct/presentation/manager/addBike/cubit/add_bike_cubit.dart';
import 'package:ejar/features/addProduct/presentation/manager/uploadImg/cubit/upload_img_cubit.dart';
import 'package:ejar/features/addProduct/presentation/widgets/custom_upload_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBikePage extends StatelessWidget {
  const AddBikePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddBikeCubit()),
        BlocProvider(create: (context) => UploadImgCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Add Your Bike")),
        body: BlocConsumer<AddBikeCubit, AddBikeState>(
          listener: (context, state) {
            if (state is AddBikeSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            } else if (state is AddBikeFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddBikeCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BlocBuilder<UploadImgCubit, UploadImgState>(
                    builder: (context, imgState) {
                      final imgCubit = context.read<UploadImgCubit>();
                      // final state = imgState as UploadImgSuccess;
                      return CustomUploadImage(
                        state: imgState,
                        onTap: () async {
                          await imgCubit.pickImg();
                          await cubit.storeImg(img: imgCubit.image!);
                        },
                      );
                    },
                  ),
                  20.gap,
                  CustomAuthField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    label: "Bike Type (Mountain/Road)",
                    icon: Icons.pedal_bike,
                    controller: cubit.type,
                  ),
                  15.gap,
                  CustomAuthField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    label: "Condition",
                    icon: Icons.info_outline,
                    controller: cubit.condition,
                  ),
                  15.gap,
                  CustomAuthField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    label: "Hourly/Daily Rate",
                    icon: Icons.timer,
                    controller: cubit.price_per_day,
                  ),
                  30.gap,
                  ElevatedButton(
                    onPressed: () async {
                      await cubit.addBike();
                    },
                    child: const Text("Post Bike"),
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
