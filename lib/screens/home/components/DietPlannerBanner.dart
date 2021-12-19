import 'package:flutter/material.dart';

class DietPlanBanner extends StatelessWidget {
  const DietPlanBanner({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            "https://fitclic.net/wp-content/uploads/2021/10/custom-keto-diet-banner.png",
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
