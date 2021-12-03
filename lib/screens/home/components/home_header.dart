import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthfix/components/rounded_icon_button.dart';
import 'package:healthfix/components/search_field.dart';
import 'package:flutter/material.dart';

import '../../../components/icon_button_with_counter.dart';
import '../../../constants.dart';

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
          color: kPrimaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // RoundedIconButton(
              //   iconData: Icons.menu,
              //   press: () {
              //     Scaffold.of(context).openDrawer();
              //   },
              // ),
              Container(
                width: 40,
                child: Image.asset('assets/logo/hf-logo-only.png'),
              ),
              Container(
                width: 300,
                child: SearchField(
                  onSubmit: onSearchSubmitted,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.account_circle_sharp),
                color: Colors.white,
                splashRadius: 20,
              ),
            ],
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
