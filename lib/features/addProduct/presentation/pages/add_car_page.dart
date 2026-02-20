import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/core/routes/custom_auth_field.dart';
import 'package:ejar/core/widgets/custom_upload_img.dart';
import 'package:flutter/material.dart';

class AddCarPage extends StatelessWidget {
  const AddCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rent Out Your Car")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CustomUploadImage(),
            20.gap,
            CustomAuthField(
              controller: TextEditingController(),
              label: "Car Model (e.g. BMW 2024)",
              icon: Icons.directions_car,
            ),
            15.gap,
            CustomAuthField(
              controller: TextEditingController(),
              label: "Transmission (Auto/Manual)",
              icon: Icons.settings,
            ),
            15.gap,
            CustomAuthField(
              controller: TextEditingController(),
              label: "Daily Rent Price",
              icon: Icons.payments,
            ),
            15.gap,
            CustomAuthField(
              controller: TextEditingController(),
              label: "Fuel Type",
              icon: Icons.local_gas_station,
            ),
            30.gap,
            ElevatedButton(onPressed: () {}, child: const Text("Post Car")),
          ],
        ),
      ),
    );
  }
}
