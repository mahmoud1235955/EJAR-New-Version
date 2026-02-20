import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/core/routes/custom_auth_field.dart';
import 'package:ejar/core/widgets/custom_upload_img.dart';
import 'package:flutter/material.dart';

class AddPropertyPage extends StatelessWidget {
  const AddPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Property")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CustomUploadImage(), // ويدجت لرفع الصور
            20.gap,
            CustomAuthField(
              controller: TextEditingController(),
              label: "Property Title",
              icon: Icons.home,
            ),
            15.gap,
            CustomAuthField(
              controller: TextEditingController(),
              label: "Location",
              icon: Icons.location_on,
            ),
            15.gap,
            CustomAuthField(
              controller: TextEditingController(),
              label: "Monthly Rent (EGP)",
              icon: Icons.money,
            ),
            15.gap,
            CustomAuthField(
              controller: TextEditingController(),
              label: "Rooms / Bathrooms",
              icon: Icons.bed,
            ),
            30.gap,
            ElevatedButton(
              onPressed: () {},
              child: const Text("Post Property"),
            ),
          ],
        ),
      ),
    );
  }
}
