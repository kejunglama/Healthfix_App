import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthfix/data.dart';
import 'package:healthfix/models/Product.dart';
import 'package:healthfix/screens/category_products/category_products_screen.dart';
import 'package:healthfix/screens/checkout/checkout_screen.dart';
import 'package:healthfix/services/database/product_database_helper.dart';
import 'package:healthfix/size_config.dart';

import '../../../constants.dart';
import 'home_screen_drawer.dart';

// Cleaning
class HomeHeader extends StatelessWidget {
  final Function onSearchSubmitted;
  final Function onCartButtonPressed;

  const HomeHeader({
    Key key,
    @required this.onSearchSubmitted,
    @required this.onCartButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Container(
                margin: EdgeInsets.only(left: getProportionateScreenWidth(12)),
                height: getProportionateScreenHeight(30),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutScreen()),
                      );
                    },
                    child: Image.asset('assets/logo/HF-logo.png')),
              ),

              // Icons
              Container(
                margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
                child: Row(
                  children: [
                    // Btn - Search
                    Container(
                      width: getProportionateScreenWidth(35),
                      child: IconButton(
                        // onPressed: () async {
                        //   List searchedProductsId = await ProductDatabaseHelper().searchInProducts("");
                        //   await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => CategoryProductsScreen(
                        //         productType: ProductType.All,
                        //         productTypes: pdctCategories,
                        //         subProductType: "",
                        //       ),
                        //     ),
                        //   );
                        // },
                        onPressed: (){},
                        icon: Icon(Icons.favorite_border_outlined),
                        color: kPrimaryColor,
                        splashRadius: 20,
                      ),
                    ),

                    // Btn - Account
                    Container(
                      width: getProportionateScreenWidth(35),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreenDrawer()),
                          );
                        },
                        icon: Icon(Icons.account_circle_sharp),
                        color: kPrimaryColor,
                        splashRadius: 20,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),

        // Search Bar
        // Container(
        //   margin: EdgeInsets.fromLTRB(
        //       getProportionateScreenWidth(8), getProportionateScreenHeight(2), getProportionateScreenWidth(8), getProportionateScreenHeight(8)),
        //   child: SearchField(onSubmit: onSearchSubmitted),
        // ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(
        //       child: SearchField(
        //         onSubmit: onSearchSubmitted,
        //       ),
        //     ),
        //     SizedBox(width: 5),
        //     IconButtonWithCounter(
        //       svgSrc: "assets/icons/Cart Icon.svg",
        //       numOfItems: 0,
        //       press: onCartButtonPressed,
        //     ),IconButtonWithCounter(
        //       svgSrc: "assets/icons/Bell.svg",
        //       numOfItems: 0,
        //       press: onCartButtonPressed,
        //     ),
        //   ],
        // ),
        searchBar(context),
      ],
    );
  }

  Widget searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(
              productType: ProductType.All,
              productTypes: pdctCategories,
              subProductType: "",
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.3, color: Colors.grey),
        ),
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(10)),
          height: getProportionateScreenHeight(40),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: Colors.cyan,
                size: getProportionateScreenHeight(20),
              ),
              Container(
                margin: EdgeInsets.only(left: getProportionateScreenWidth(10)),
                child: Text(
                  "Search Products, Brands, Vendors",
                  style: cusHeadingStyle(14, Colors.grey, null, FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
