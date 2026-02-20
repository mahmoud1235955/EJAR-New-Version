import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/core/routes/custom_auth_field.dart';
import 'package:ejar/core/widgets/custom_upload_img.dart';
import 'package:flutter/material.dart';

class AddBikePage extends StatelessWidget {
  const AddBikePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Your Bike")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomUploadImage(),
            20.gap,
            CustomAuthField(
              label: "Bike Type (Mountain/Road)",
              icon: Icons.pedal_bike,
              controller: TextEditingController(),
            ),
            15.gap,
            CustomAuthField(
              label: "Condition",
              icon: Icons.info_outline,
              controller: TextEditingController(),
            ),
            15.gap,
            CustomAuthField(
              label: "Hourly/Daily Rate",
              icon: Icons.timer,
              controller: TextEditingController(),
            ),
            30.gap,
            ElevatedButton(onPressed: () {}, child: const Text("Post Bike")),
          ],
        ),
      ),
    );
  }
}
