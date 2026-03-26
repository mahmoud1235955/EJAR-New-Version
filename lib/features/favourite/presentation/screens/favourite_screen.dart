import 'package:ejar/features/favourite/presentation/manager/AddFav/cubit/add_to_fav_cubit.dart';
import 'package:ejar/features/favourite/presentation/manager/ReciveFav/cubit/recive_fav_cubit.dart';
import 'package:ejar/features/home/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // السطر ده بينادي الـ Stream مرة واحدة عند فتح الصفحة
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
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => _showDeleteAllDialog(context),
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
      // بنخلي الـ Rebuild يحصل فقط في حالات معينة للحفاظ على الأداء
      buildWhen: (previous, current) =>
          current is ReciveFavSuccess ||
          current is ReciveFavLoading ||
          current is ReciveFavFailure,
      builder: (context, state) {
        if (state is ReciveFavLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ReciveFavFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is ReciveFavSuccess) {
          if (state.favorites.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: state.favorites.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = state.favorites[index];

              return Dismissible(
                // مهم جداً: الـ Key لازم يكون الـ ID الفريد من الداتا بأس
                key: Key(item['id'].toString()),
                direction: DismissDirection.startToEnd,

                // الخلفية عند السحب (Delete)
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.redAccent,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                // الأكشن الفعلي عند الحذف
                confirmDismiss: (direction) async {
                  // بننادي الكيوبيت يمسح من السيرفر (تأكد إنك شلت الـ Loading من ميثود الحذف في الكيوبيت)
                  context.read<ReciveFavCubit>().deleteProduct(item['id']);
                  return true; // بيخلي الـ Widget تختفي والـ Stream هيحدث اللستة
                },

                child: ProductWidget(
                  productId: item['product_id'].toString(),
                  category: item['category'] ?? 'Property',
                  productName: item['name'] ?? 'No Name',
                  productPrice: item['price_per_day']?.toString() ?? '0',
                  productLocation: item['location'] ?? 'Unknown',
                  productShortDescription: item['descripttion'] ?? '',
                  imgPath: item['image_url'] ?? '',
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            "Your list is empty",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Start adding properties to your favorites!",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Dialog تأكيد لمسح الكل (احترافي أكتر)
  void _showDeleteAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Clear Favorites?"),
        content: const Text("Are you sure you want to remove all items?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<ReciveFavCubit>().deleteFav();
              Navigator.pop(dialogContext);
            },
            child: const Text(
              "Delete All",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
