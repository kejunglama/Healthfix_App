import 'package:flutter/material.dart';
import 'package:healthfix/models/Product.dart';

import 'components/body.dart';

class CategoryProductsScreen extends StatelessWidget {
  final ProductType productType;
  final List<Map> productTypes;

  const CategoryProductsScreen({
    Key key,
    this.productType,
    this.productTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(productTypes);
    return Scaffold(
      body: Body(
        productType: productType,
        productTypes: productTypes,
      ),
    );
  }
}
