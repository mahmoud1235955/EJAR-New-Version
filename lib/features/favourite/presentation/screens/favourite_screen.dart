import 'package:ejar/features/favourite/presentation/manager/AddFav/cubit/add_to_fav_cubit.dart';
import 'package:ejar/features/favourite/presentation/manager/ReciveFav/cubit/recive_fav_cubit.dart';
import 'package:ejar/features/home/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. بنستخدم BlocProvider وننادي على reciveFav فوراً
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReciveFavCubit()..reciveFav()),
        BlocProvider(create: (context) => AddToFavCubit()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FA),
        appBar: AppBar(
          title: const Text(
            "My Favorites",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // 2. زرار مسح الكل مربوط بـ deleteFav في الـ Cubit
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    context.read<ReciveFavCubit>().deleteFav();
                  },
                  icon: const Icon(
                    Icons.delete_sweep_outlined,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: _buildFavoriteGrid(),
        ),
      ),
    );
  }

  Widget _buildFavoriteGrid() {
    return BlocBuilder<ReciveFavCubit, ReciveFavState>(
      builder: (context, state) {
        if (state is ReciveFavLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReciveFavFailure) {
          return Center(child: Text(state.message));
        } else if (state is ReciveFavSuccess) {
          // 3. لو القائمة فاضية بنعرض الـ Empty State اللي صممته
          if (state.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "No Favorites Yet!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // 4. عرض البيانات الحقيقية
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: state.favorites.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = state.favorites[index];
              return ProductWidget(
                // بنبعت الـ IDs الحقيقية اللي جاية من جدول المفضلات
                productId: item['product_id'].toString(),
                category: item['category'] ?? '',
                productName: item['name'] ?? '',
                productPrice: item['price_per_day'] ?? '',
                productLocation: item['location'] ?? '',
                productShortDescription: item['descripttion'] ?? '',
                imgPath:
                    item['image_url'] ??
                    '', // تقدر هنا تعرض صورة افتراضية أو اللوجو
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
