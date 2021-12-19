import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  final String svgIcon;
  const CustomSuffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Container(
        width: 20,
        height: 20,
        child: Center(
          child: SvgPicture.asset(
            svgIcon,
            height: getProportionateScreenWidth(18),
          ),
        ),
      ),
    );
  }
}
