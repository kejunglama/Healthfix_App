import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: cusCenterHeadingStyle(),
        ),
      ),
      body: Body(),
    );
  }
}
