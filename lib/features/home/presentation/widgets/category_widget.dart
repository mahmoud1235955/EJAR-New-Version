import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.imgPath,
    required this.categoryName,
  });
  final String imgPath;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            SvgPicture.asset(imgPath, width: 44, height: 38),
            5.gap,
            Text(
              categoryName,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
