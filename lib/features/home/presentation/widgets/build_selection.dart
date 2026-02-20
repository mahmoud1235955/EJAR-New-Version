import 'package:flutter/material.dart';

Widget buildSelectionOption(
  BuildContext context, {
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xff087513).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 35, color: const Color(0xff087513)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    ),
  );
}
