import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/size_config.dart';

class TopBrandCardRow extends StatelessWidget {
  const TopBrandCardRow({
    Key key,
    @required this.topBrandsList,
  }) : super(key: key);

  final List<String> topBrandsList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TopBrandCard(topBrandsList[0]),
        SizedBox(width: getProportionateScreenWidth(12)),
        TopBrandCard(topBrandsList[1]),
        SizedBox(width: getProportionateScreenWidth(12)),
        TopBrandCard(topBrandsList[2]),
      ],
    );
  }
}

class TopBrandCard extends StatelessWidget {
  final String imageURL;

  const TopBrandCard(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(90),
      height: getProportionateScreenHeight(90),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: kTextColor.withOpacity(0.15)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              imageURL,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
