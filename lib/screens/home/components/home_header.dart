import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthfix/components/rounded_icon_button.dart';
import 'package:healthfix/components/search_field.dart';
import 'package:healthfix/screens/explore_fitness/explore_screen.dart';
import 'package:healthfix/screens/search/search_screen.dart';
import 'package:healthfix/screens/search_result/search_result_screen.dart';
import 'package:healthfix/services/database/product_database_helper.dart';
import 'package:healthfix/size_config.dart';

import '../../../constants.dart';
import 'home_screen_drawer.dart';

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
          // color: kPrimaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // RoundedIconButton(
                  //   iconData: Icons.menu,
                  //   press: () {
                  //     Scaffold.of(context).openDrawer();
                  //   },
                  // ),
                  SizedBox(width: getProportionateScreenWidth(12)),
                  Container(
                    height: 30,
                    // height: 0,
                    child: Image.asset('assets/logo/HF-logo.png'),
                  ),
                ],
              ),
              // IconButton(
              //   onPressed: () {Scaffold.of(context).openDrawer();},
              //   icon: Icon(Icons.menu),
              //   color: kPrimaryColor,
              //   splashRadius: 20,
              // ),

              // Container(
              //   width: 300,
              //   child: SearchField(
              //     onSubmit: onSearchSubmitted,
              //   ),
              // ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      width: 40,
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
                    Container(
                      width: 40,
                      child: IconButton(
                        onPressed: () async{
                          List searchedProductsId = await ProductDatabaseHelper().searchInProducts("");
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultScreen(
                                searchQuery: "",
                                searchResultProductsId: searchedProductsId,
                                searchIn: "All Products",
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.search_rounded),
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
        Container(
          margin: EdgeInsets.fromLTRB(8,2,8,8),
          // width: 300,
          child: SearchField(
            onSubmit: onSearchSubmitted,
          ),
        ),
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
      ],
    );
  }
}
