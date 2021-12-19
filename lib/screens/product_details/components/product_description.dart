import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthfix/models/Product.dart';
import 'package:healthfix/screens/product_details/provider_models/ColorVariations.dart';
import 'package:healthfix/screens/product_details/provider_models/VariantBuilder.dart';
import 'package:healthfix/size_config.dart';

import '../../../constants.dart';
import 'expandable_text.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  final sizes = new Set();
  final colors = new Set();

  //
  // List jsonArray = [
  //   {"size": "S", "color": "FEAF3A", "price": 14000},
  //   {"size": "S", "color": "FE743A", "price": 15000},
  //   {"size": "M", "color": "FEAF3A", "price": 16000},
  //   {"size": "M", "color": "FEAA8A", "price": 16000},
  //   {"size": "M", "color": "FE113A", "price": 16000},
  //   {"size": "L", "color": "FE743A", "price": 20000},
  //   {"size": "L", "color": "3A81FE", "price": 22000},
  // ];

  ProductDescription({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List jsonArray;
    bool hasVariation = product.variations != null;
    if (hasVariation) {
      jsonArray = product.variations;
      jsonArray.forEach((variant) {
        sizes.add(variant["size"]);
        colors.add(variant["color"]);
      });
    }

    print(product.variations);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Title
              Text.rich(
                TextSpan(
                  text: product.title.capitalize(),
                  style: cusCenterHeadingStyle(),
                  children: [
                    TextSpan(
                      text: "\n${product.variant.capitalize()} ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Text(product.highlights),
              // const SizedBox(height: 16),

              // Product Variation with Price
                ProductVariationDescription(
                  product: product,
                  sizes: sizes,
                  jsonArray: jsonArray,
                  colors: colors,
                ),

              const SizedBox(height: 16),
              ExpandableText(
                title: "Description",
                content: product.description,
              ),
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: "By ",
                  style: cusHeadingStyle(
                      getProportionateScreenHeight(14), Colors.black87),
                  children: [
                    TextSpan(
                      text: "${product.seller}",
                      style: TextStyle(
                          // decoration: TextDecoration.underline,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductVariationDescription extends StatefulWidget {
  const ProductVariationDescription({
    Key key,
    @required this.product,
    @required this.sizes,
    @required this.jsonArray,
    @required this.colors,
  }) : super(key: key);

  final Product product;
  final Set sizes;
  final List jsonArray;
  final Set colors;

  @override
  State<ProductVariationDescription> createState() =>
      _ProductVariationDescriptionState();
}

class _ProductVariationDescriptionState
    extends State<ProductVariationDescription> {
  List _colors = [];

  setColors(List colors) {
    setState(() {
      _colors = colors;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasVariations =  widget.jsonArray != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(55),
          child: Text.rich(
            TextSpan(
              text: "Rs. ${widget.product.discountPrice}   ",
              style: cusPdctDisPriceStyle(25),
              children: [
                TextSpan(
                  text: "\nRs. ${widget.product.originalPrice}",
                  style: cusPdctOriPriceStyle(18),
                ),
                TextSpan(
                  text:
                      "   ${widget.product.calculatePercentageDiscount()}% OFF",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.red,
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  // textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
        if(hasVariations) Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(12)),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Size",
                    style: cusHeadingStyle(getProportionateScreenWidth(16)),
                  ),
                ),
                // SizedBox(height: getProportionateScreenHeight(12)),
                variantsBuilder(
                    variants: widget.sizes.toList(),
                    json: widget.jsonArray,
                    setVariant: setColors),
              ],
            ),
            // SizedBox(height: getProportionateScreenHeight(20)),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Available Colors",
                    style: cusHeadingStyle(getProportionateScreenWidth(16)),
                  ),
                ),
                // SizedBox(height: getProportionateScreenHeight(12)),
                ColorvariantsBuilder(
                  colors: _colors.isNotEmpty ? _colors : widget.colors.toList(),
                  selectable: _colors.isNotEmpty,
                ),
              ],
            ),
          ],
        ),

      ],
    );
  }
}

// class variantRadioBt1n extends StatelessWidget {
//
//
//   const variantRadioBtn(this.selected,
//       this.id, {
//         Key key,
//       }) : super(key: key);
//
//   final int id;
//   final int selected;
//
//   @override
//   State<variantRadioBtn> createState() => _variantRadioBtnState();
// }
//
// class _variantRad23ioBtnState extends State<variantRadioBtn> {
//   @override
//   Widget build(BuildContext context) {
//     // int Selected = widget.selectIndex ?? 0;
//
//     var _selected = selected;
//     return Container(
//       width: 30,
//       height: 30,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 1,
//           color: _selected == id ? kPrimaryColor : Colors.grey,
//         ),
//       ),
//       child: Center(
//           child: Text(
//             "S",
//             style: TextStyle(
//               color: _isSelected ? kPrimaryColor : Colors.grey,
//             ),
//           )),
//     );
//   }
// }
