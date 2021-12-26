import 'package:flutter/material.dart';
import 'package:healthfix/screens/home/components/product_variation.dart';
import 'package:healthfix/size_config.dart';

import '../../../constants.dart';

class variantsBuilder extends StatefulWidget {
  final List variants;
  final List json;
  final setSize;

  const variantsBuilder(
      {Key key, @required this.variants, this.json, this.setSize})
      : super(key: key);

  @override
  State<variantsBuilder> createState() => _variantsState();
}

class _variantsState extends State<variantsBuilder> {
  int _selected;

  @override
  Widget build(BuildContext context) {
    List _variant = widget.variants;
    List _json = widget.json;

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < _variant.length; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                _selected = i;
              });
              widget.setSize(
                _variant[i],
                fetchValuesFromVariant(
                  "color",
                  findVariantWithKey(_variant[i], "size", _json),
                  _json,
                ),
              );
              print(
                fetchValuesFromVariant(
                  "color",
                  findVariantWithKey(_variant[i], "size", _json),
                  _json,
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                right: getProportionateScreenHeight(12),
                // top: getProportionateScreenWidth(18),
                // bottom: getProportionateScreenWidth(18),
              ),
              width: getProportionateScreenWidth(35),
              height: getProportionateScreenWidth(35),
              decoration: BoxDecoration(
                color: i == _selected ? kPrimaryColor.withOpacity(0.4) : Colors.transparent,
                // border: Border.all(
                //   width: 1,
                //   color: i == _selected ? kPrimaryColor : Colors.transparent,
                // ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _variant[i],
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
