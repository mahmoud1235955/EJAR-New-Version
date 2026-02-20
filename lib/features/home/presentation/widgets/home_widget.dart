import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/features/home/presentation/widgets/category_widget.dart';
import 'package:ejar/features/home/presentation/widgets/product_widget.dart';
import 'package:ejar/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (value) {},
              controller: PageController(initialPage: 0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryWidget(
                imgPath:
                    "assets/icons/material-symbols_directions-bike-sharp.svg",
                categoryName: "Bikes",
              ),
              CategoryWidget(
                imgPath: "assets/icons/Vector (1).svg",
                categoryName: "Cars",
              ),
              CategoryWidget(
                imgPath: "assets/icons/Vector (2).svg",
                categoryName: "Properties",
              ),
            ],
          ),
          10.gap,
          Container(
            padding: EdgeInsets.only(top: 45, left: 15, right: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) {
                return 10.gap;
              },
              itemBuilder: (context, index) {
                return ProductWidget(
                  imgPath: "assets/icons/3n.png",
                  productLocation:
                      "vvjhvjhvcayudsgyufwegddlisiueflgiufdlihciah;",
                  productName: "nkbbuiguy",
                  productPrice: "253636",
                  productShortDescription: "jkskjdjsjksui",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
