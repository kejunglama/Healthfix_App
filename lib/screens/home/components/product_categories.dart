import 'package:flutter/material.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/data.dart';
import 'package:healthfix/screens/category_products/category_products_screen.dart';
import 'package:healthfix/size_config.dart';

import 'product_type_box.dart';

// Cleaned
class ProductCategories extends StatelessWidget {
  void Function() goToCategory;

  ProductCategories(this.goToCategory, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
          child: Padding(
            padding: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category", style: cusHeadingStyle()),
                GestureDetector(onTap: goToCategory,child: Text("See More >", style: cusHeadingLinkStyle)),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(110),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                ...List.generate(
                  pdctCategories.length,
                  (index) {
                    return ProductTypeBox(
                      icon: pdctCategories[index][ICON_KEY],
                      title: pdctCategories[index][TITLE_KEY],
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryProductsScreen(
                              productType: pdctCategories[index][PRODUCT_TYPE_KEY],
                              productTypes: pdctCategories,
                              subProductType: "",
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
