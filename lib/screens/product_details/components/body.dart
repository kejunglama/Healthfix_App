import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthfix/components/rounded_icon_button.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/models/Product.dart';
import 'package:healthfix/screens/cart/cart_screen.dart';
import 'package:healthfix/screens/product_details/components/product_actions_section.dart';
import 'package:healthfix/screens/product_details/components/product_images.dart';
import 'package:healthfix/services/database/product_database_helper.dart';
import 'package:healthfix/size_config.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'fab.dart';

class Body extends StatefulWidget {
  final String productId;

  Body({
    Key key,
    @required this.productId,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  num _productDisPrice, _productOriPrice;
  Product product;
  String _selectedColor;
  String _selectedSize;
  Map selectedVariations;
  var numFormat = NumberFormat('#,##,000');

  @override
  void initState() {
    super.initState();
  }

  void setSelectedVariant(String size, String color) {
    _selectedColor = color;
    _selectedSize = size;
    print("Variants: $_selectedColor $_selectedSize");

    List variant =
        product.variations.where((variant) => variant["size"] == _selectedSize).where((variant) => variant["color"] == _selectedColor).toList();
    // print(variant.first["price"]);
    setState(() {
      _productDisPrice = int.parse(variant.first["price"]);
      _productOriPrice = 1.2 * _productDisPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<Product>(
          future: ProductDatabaseHelper().getProductWithID(widget.productId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              product = snapshot.data;
              // print("product");
              // print(product);
              if (_productDisPrice == null) {
                _productDisPrice = product.discountPrice;
                _productOriPrice = 1.2 * _productDisPrice;
              }
              return Stack(
                children: [
                  Scaffold(
                    body: SafeArea(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RoundedIconButton(
                                      iconData: Icons.arrow_back_ios_rounded,
                                      press: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(width: getProportionateScreenWidth(15)),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.zero,
                                        alignment: Alignment.centerLeft,
                                        height: getProportionateScreenHeight(30),
                                        child: Image.asset('assets/logo/HF-logo.png'),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: getProportionateScreenWidth(8)),
                                          child: Icon(
                                            Icons.search_rounded,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => CartScreen()),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: getProportionateScreenWidth(8)),
                                            child: Icon(
                                              Icons.shopping_bag,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ProductImages(product: product),
                              // SizedBox(height: getProportionateScreenHeight(20)),
                              ProductActionsSection(product: product, setSelectedVariant: setSelectedVariant),
                              SizedBox(height: getProportionateScreenHeight(80)),
                              // ProductReviewsSection(product: product),
                              // SizedBox(height: getProportionateScreenHeight(100)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ),
                  ),
                  bottomProductBar(),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              final error = snapshot.error.toString();
              Logger().e(error);
            }
            return Center(
              child: Icon(
                Icons.error,
                color: kTextColor,
                size: 60,
              ),
            );
          },
        ),
      ],
    );
  }

  Positioned bottomProductBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        height: getProportionateScreenHeight(70),
        width: SizeConfig.screenWidth,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: getProportionateScreenHeight(60),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rs. ${numFormat.format(_productDisPrice)}  ",
                        style: cusPdctPageDisPriceStyle(getProportionateScreenHeight(26), Colors.black),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rs. ${numFormat.format(_productOriPrice)}",
                            style: cusPdctOriPriceStyle(getProportionateScreenHeight(12)),
                          ),
                          sizedBoxOfWidth(8),
                          Text(
                            // "${product.calculatePercentageDiscount()}% OFF",
                            "20% OFF",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: getProportionateScreenHeight(12),
                                fontWeight: FontWeight.w600,
                                letterSpacing: getProportionateScreenHeight(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // VerticalDivider(
            //   thickness: 1,
            //   color: Colors.white,
            // ),

            // AddToCartFAB(productId: product.id),
            // InkWell(
            //   onTap: () {
            //     // print(product);
            //     if (product.variations != null) {
            //       if (_selectedSize == null) {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text("Please Select a Size"),
            //           ),
            //         );
            //       } else if (_selectedColor == null) {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text("Please Select a Color"),
            //           ),
            //         );
            //       } else {
            //         selectedVariations = {"size": _selectedSize, "color": _selectedColor};
            //         print(selectedVariations);
            //       }
            //     } else {
            //       selectedVariations = {};
            //     }
            //   },
            //   child: Container(
            //     child: Text("Check"),
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                if (product.variations != null) {
                  if (_selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please Select a Size"),
                      ),
                    );
                  } else if (_selectedColor == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please Select a Color"),
                      ),
                    );
                  } else {
                    selectedVariations = {"size": _selectedSize, "color": _selectedColor};
                    print(selectedVariations);
                  }
                } else {
                  selectedVariations = {};
                }
                AddToCartFAB(
                  productId: product.id,
                  variations: selectedVariations,
                );
              },
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: kPrimaryColor,
                ),
                label: Text(
                  "Add to Cart",
                  style: cusHeadingStyle(
                    getProportionateScreenHeight(14),
                    kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setVariantPrices(num disPrice, num oriPrice) {
    setState(() {
      _productDisPrice = disPrice;
      _productOriPrice = oriPrice;
    });
  }
}
