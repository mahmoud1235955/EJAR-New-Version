import 'package:ejar/features/addProduct/presentation/pages/add_bike_page.dart';
import 'package:ejar/features/addProduct/presentation/pages/add_car_page.dart';
import 'package:ejar/features/addProduct/presentation/pages/add_propirty_page.dart';
import 'package:flutter/material.dart';

class AddSelectionSheet extends StatelessWidget {
  const AddSelectionSheet({super.key});

  // دالة مساعدة لرسم الخيارات عشان الكود يبقى منظم
  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget targetPage,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // قفل الشيت أولاً
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xff087513).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: const Color(0xff087513)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // بياخد مساحة المحتوى بس
        children: [
          // الخط الرمادي الصغير اللي فوق (Handle)
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "What do you want to add?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(
                context,
                icon: Icons.home_work_rounded,
                label: "Property",
                targetPage: const AddPropertyPage(), // صفحاتك اللي عملناها
              ),
              _buildOption(
                context,
                icon: Icons.directions_car_filled,
                label: "Car",
                targetPage: const AddCarPage(),
              ),
              _buildOption(
                context,
                icon: Icons.pedal_bike,
                label: "Bike",
                targetPage: const AddBikePage(),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
