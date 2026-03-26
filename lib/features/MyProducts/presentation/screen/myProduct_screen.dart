import 'package:ejar/features/MyProducts/presentation/Manager/MyProduct/cubit/my_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyProductCubit()..getMyProduct(),
      child: Scaffold(
        appBar: AppBar(title: const Text("My Products"), centerTitle: true),
        body: BlocBuilder<MyProductCubit, MyProductState>(
          builder: (context, state) {
            if (state is MyProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyProductError) {
              return Text(state.message);
            } else if (state is MyProductSuccess) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length, // عدد تجريبي للمنتجات
                itemBuilder: (context, index) {
                  return _buildProductItem(
                    context,
                    product: state.products[index],
                  );
                },
              );
            } else {
              return const Center(child: Text("No Products"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, {required dynamic product}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // 1. صورة المنتج (Assets أو Network)
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(product.image), // الصورة اللي رفعناها
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),

            // 2. تفاصيل المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product.price,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 3. أزرار التحكم (Edit & Delete)
                  Row(
                    children: [
                      _buildActionButton(
                        icon: Icons.edit_outlined,
                        color: Colors.blue,
                        onTap: () {
                          // TODO: Navigate to Edit Page
                        },
                      ),
                      const SizedBox(width: 15),
                      _buildActionButton(
                        icon: Icons.delete_outline,
                        color: Colors.red,
                        onTap: () {
                          _showDeleteDialog(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildActionButton({
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 22),
    ),
  );
}

void _showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Product?"),
      content: const Text(
        "Are you sure you want to remove this car from Ejar?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // TODO: Delete Logic using Cubit
            Navigator.pop(context);
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
