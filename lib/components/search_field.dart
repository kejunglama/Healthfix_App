import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class SearchField extends StatelessWidget {
  final Function onSubmit;
  const SearchField({
    Key key,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        // color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 0.3,
          color: Colors.grey,
        ),
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          // enabledBorder: InputBorder.none,
          hintText: "Search...",
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.cyan,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(12),
          ),
        ),
        onSubmitted: onSubmit,
      ),
    );
  }
}
