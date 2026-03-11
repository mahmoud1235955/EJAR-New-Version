import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/features/RentNow/presentation/screens/rent_now_sceen.dart';
import 'package:ejar/features/favourite/presentation/manager/AddFav/cubit/add_to_fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.imgPath,
    required this.productName,
    required this.productPrice,
    required this.productLocation,
    required this.productShortDescription,
    required this.category,
    required this.productId,
  });

  final String imgPath;
  final String productName;
  final String productPrice;
  final String productLocation;
  final String productShortDescription;
  final String category;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      // تحديد الارتفاع مهم جداً عشان الـ ListView.separated يعرف يرسمه
      height: 320,
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. الجزء العلوي (الصورة + زر المفضلة)
          Expanded(
            flex: 5, // بياخد 50% من مساحة الكارت
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: 500,
                    color: Colors.grey[100], // خلفية مؤقتة للصورة
                    child: Image.network(
                      imgPath,
                      fit: BoxFit.contain,
                      // حماية في حالة لو الرابط بايظ أو لسه بيحمل
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: BlocListener<AddToFavCubit, AddToFavState>(
                    // الـ Listener وظيفته بس يظهر SnackBar لما العملية تنجح أو تفشل
                    listener: (context, state) {
                      if (state is AddToFavSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("تمت الإضافة للمفضلة! ❤️"),
                          ),
                        );
                      } else if (state is AddToFavFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      radius: 18,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          context.read<AddToFavCubit>().addToFav(
                            category: category,
                            product_id: productId,
                            product_name: productName,
                            product_price: productPrice,
                            product_image: imgPath,
                            product_location: productLocation,
                            product_description: productShortDescription,
                          );
                        },
                        icon: const Icon(
                          Icons.favorite_outline,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          12.gap,

          // 2. الجزء الأوسط (النصوص)
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.gap,
                Text(
                  productShortDescription,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    4.gap,
                    Expanded(
                      child: Text(
                        productLocation,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 3. الجزء السفلي (السعر + الزرار)
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    "$productPrice L.E",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff087513),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RentNowSceen(
                        productData: {
                          "category": category,
                          "product_id": productId,
                          "product_name": productName,
                          "product_price": productPrice,
                          "product_image": imgPath,
                          "product_location": productLocation,
                          "product_description": productShortDescription,
                        },
                        // category: category,
                        // product_id: productId,
                        // product_name: productName,
                        // product_price: productPrice,
                        // product_image: imgPath,
                        // product_location: productLocation,
                        // product_description: productShortDescription,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff087513),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text(
                  "Rent Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
