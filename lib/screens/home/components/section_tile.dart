import 'package:flutter/material.dart';
import 'package:healthfix/constants.dart';

class SectionTile extends StatelessWidget {
  final String title;
  final GestureTapCallback press;

  const SectionTile({
    Key key,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: cusHeadingStyle(),
          ),
          Text(
            "See More >",
            style: cusHeadingLinkStyle,
          ),
        ],
      ),
    );
  }
}
