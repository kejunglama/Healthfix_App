import 'package:flutter/material.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/screens/product_details/provider_models/ProductActions.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import 'components/body.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({
    Key key,
    @required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductActions(),
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          leadingWidth: getProportionateScreenWidth(12),
          title: Container(
            margin: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            height: getProportionateScreenHeight(30),
            child: Image.asset('assets/logo/HF-logo.png'),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: getProportionateScreenWidth(8)),
              child: Icon(
                Icons.search_rounded,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: getProportionateScreenWidth(8)),
              child: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ],
          // backgroundColor: Colors.transparent,
        ),
        body: Body(
          productId: productId,
        ),
        // floatingActionButton: AddToCartFAB(productId: productId),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: kPrimaryColor,
            height: getProportionateScreenHeight(50),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Add to Cart",
                      style: cusHeadingStyle(
                        getProportionateScreenHeight(14),
                        Colors.white,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.white,
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Buy Now",
                      style: cusHeadingStyle(
                        getProportionateScreenHeight(14),
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
