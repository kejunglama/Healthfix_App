import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductTypeBox extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPress;

  const ProductTypeBox({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            margin: EdgeInsets.only(
              right: 12,
            ),
            padding: EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.09),
              borderRadius: BorderRadius.circular(5),
              // border: Border.all(
              //   color: kPrimaryColor.withOpacity(0.18),
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: SvgPicture.asset(
                  icon,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          // SizedBox(height: 2),
          Container(
            margin: EdgeInsets.only(
              right: 12,
              top: 5,
            ),
            width: 70,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: cusPdctCatNameStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
