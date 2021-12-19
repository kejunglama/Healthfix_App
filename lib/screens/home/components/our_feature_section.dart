import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/screens/home/components/our_feature_card.dart';
import 'package:healthfix/size_config.dart';

class OurFeaturesSection extends StatelessWidget {
  const OurFeaturesSection({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // SizedBox(height: getProportionateScreenHeight(12)),
            // Container(
            //   alignment: Alignment.center,
            //   child: Text(
            //     "Our Features",
            //     style: cusCenterHeadingStyle(),
            //   ),
            // ),
            SizedBox(height: getProportionateScreenHeight(8)),
            OurFeatureCard(
              Icon(Icons.verified_user_outlined, size: 30, color: kPrimaryColor),
              "Authentic Products",
              "We deliver authentic products to you.",
            ),
            OurFeatureCard(
              Icon(Icons.alarm_on_rounded, size: 30, color: kPrimaryColor),
              "Same Day Delivery",
              "We deliver on the same day you order.",
            ),
            OurFeatureCard(
              Icon(Icons.restart_alt_rounded, size: 30, color: kPrimaryColor),
              "Return Policy",
              "We have return policy on our products.",
            ),
          ],
        ),
      ),
    );
  }
}
