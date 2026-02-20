import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.imgPath,
    required this.productName,
    required this.productPrice,
    required this.productLocation,
    required this.productShortDescription,
  });
  final String imgPath;
  final String productName;
  final String productPrice;
  final String productLocation;
  final String productShortDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_outline),
            ),
          ),
          Positioned(
            top: 0,
            left: 24,
            right: 44,
            child: Image.asset(imgPath, width: 260, height: 170),
          ),
          Positioned(
            top: 160,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price:  $productPrice L.E",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                6.gap,
                Text(
                  productName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                6.gap,
                Text(
                  productShortDescription,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                6.gap,
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 12),
                    Text(
                      productLocation,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 170,
            right: 15,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff087513),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Buy Now",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
