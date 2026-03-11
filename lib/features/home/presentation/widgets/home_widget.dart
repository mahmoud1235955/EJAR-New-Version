import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/features/addProduct/presentation/manager/ReciveBikes/cubit/recive_bikes_cubit.dart';
import 'package:ejar/features/addProduct/presentation/manager/RecivePropirity/cubit/recive_propirities_cubit.dart';
import 'package:ejar/features/addProduct/presentation/manager/reciveCars/cubit/recive_cars_cubit.dart';
import 'package:ejar/features/favourite/presentation/manager/AddFav/cubit/add_to_fav_cubit.dart';
import 'package:ejar/features/home/presentation/manager/ButtonIndex/cubit/buttons_index_cubit.dart';
import 'package:ejar/features/home/presentation/widgets/category_widget.dart';
import 'package:ejar/features/home/presentation/widgets/product_widget.dart';
import 'package:ejar/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ButtonsIndexCubit()..startAutoPlay()),
        BlocProvider(create: (context) => ReciveCarsCubit()..getCars()),
        BlocProvider(create: (context) => ReciveBikesCubit()..getBikes()),
        BlocProvider(
          create: (context) => RecivePropiritiesCubit()..getPropirities(),
        ),
        BlocProvider(create: (context) => AddToFavCubit()),
      ],
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: S.of(context).Search_for_products,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 150,
              child: BlocBuilder<ButtonsIndexCubit, ButtonsIndexState>(
                builder: (context, state) {
                  final cubit = context.read<ButtonsIndexCubit>();
                  return PageView.builder(
                    itemCount: 3,
                    onPageChanged: (value) {
                      cubit.pageViewIndex = value;
                    },
                    controller: cubit.pageviewController,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text("Page ${index + 1}")),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).BrowseCategories,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffAD9B9B),
                  ),
                ),
                TextButton(onPressed: () {}, child: Text("See All")),
              ],
            ),
            BlocBuilder<ButtonsIndexCubit, ButtonsIndexState>(
              builder: (context, state) {
                final cubit = context.read<ButtonsIndexCubit>();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.changeButtonIndex(0);
                      },
                      child: CategoryWidget(
                        imgPath:
                            "assets/icons/material-symbols_directions-bike-sharp.svg",
                        categoryName: "Bikes",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.changeButtonIndex(1);
                      },
                      child: CategoryWidget(
                        imgPath: "assets/icons/Vector (1).svg",
                        categoryName: "Cars",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.changeButtonIndex(2);
                      },
                      child: CategoryWidget(
                        imgPath: "assets/icons/Vector (2).svg",
                        categoryName: "properties",
                      ),
                    ),
                  ],
                );
              },
            ),
            10.gap,
            BlocBuilder<ButtonsIndexCubit, ButtonsIndexState>(
              builder: (context, state) {
                if (state is ButtonsIndexSuccess && state.buttonIndex == 1) {
                  return Container(
                    padding: EdgeInsets.only(top: 45, left: 15, right: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: BlocBuilder<ReciveCarsCubit, ReciveCarsState>(
                      builder: (context, state) {
                        if (state is ReciveCarsLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ReciveCarsFailure) {
                          return Center(child: Text(state.message));
                        } else if (state is ReciveCarsSuccess) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.cars.length,
                            separatorBuilder: (context, index) {
                              return 10.gap;
                            },
                            itemBuilder: (context, index) {
                              final car = state.cars[index];
                              return ProductWidget(
                                imgPath: car.image_url,
                                productLocation: car.name,
                                productName: car.location,
                                productPrice: car.price_per_day,
                                productShortDescription: car.descripttion,
                                category: "Cars",
                                productId: car.id.toString(),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text("Unknown Error"));
                        }
                      },
                    ),
                  );
                } else if (state is ButtonsIndexSuccess &&
                    state.buttonIndex == 0) {
                  return Container(
                    padding: EdgeInsets.only(top: 45, left: 15, right: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: BlocBuilder<ReciveBikesCubit, ReciveBikesState>(
                      builder: (context, state) {
                        if (state is ReciveBikesLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ReciveBikesFailure) {
                          return Center(child: Text(state.message));
                        } else if (state is ReciveBikesSuccess) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.bikes.length,
                            separatorBuilder: (context, index) {
                              return 10.gap;
                            },
                            itemBuilder: (context, index) {
                              final bike = state.bikes[index];
                              return ProductWidget(
                                productName: bike.name,
                                imgPath: bike.image_url,
                                productLocation: bike.location,
                                productPrice: bike.price_per_day,
                                productShortDescription: bike.descripttion,
                                category: "Bikes",
                                productId: bike.id.toString(),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text("Unknown Error"));
                        }
                      },
                    ),
                  );
                } else if (state is ButtonsIndexSuccess &&
                    state.buttonIndex == 2) {
                  return Container(
                    padding: EdgeInsets.only(top: 45, left: 15, right: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                        BlocBuilder<
                          RecivePropiritiesCubit,
                          RecivePropiritiesState
                        >(
                          builder: (context, state) {
                            if (state is RecivePropiritiesLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is RecivePropiritiesFailure) {
                              return Center(child: Text(state.message));
                            } else if (state is RecivePropiritiesSuccess) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.propirities.length,
                                separatorBuilder: (context, index) {
                                  return 10.gap;
                                },
                                itemBuilder: (context, index) {
                                  final propirity = state.propirities[index];
                                  return ProductWidget(
                                    productName: propirity.name,
                                    imgPath: propirity.image_url,
                                    productLocation: propirity.location,

                                    productPrice: propirity.price_per_day,
                                    productShortDescription:
                                        propirity.descripttion,
                                    category: "Propirity",
                                    productId: propirity.id.toString(),
                                  );
                                },
                              );
                            } else {
                              return Center(child: Text("Unknown Error"));
                            }
                          },
                        ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
