import 'package:flutter/material.dart';

import '../../../size_config.dart';

class ColorvariantsBuilder extends StatefulWidget {
  List colors;
  bool selectable; // Will be selectable when Size is Selected
  Function setColor;
  num selectedIndex;

  ColorvariantsBuilder({
    Key key,
    this.colors,
    this.selectable,
    this.setColor, this.selectedIndex,
  }) : super(key: key);

  @override
  State<ColorvariantsBuilder> createState() => _ColorvariantsBuilderState();
}

class _ColorvariantsBuilderState extends State<ColorvariantsBuilder> {
  num _selectedIndex;
  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List _colors = widget.colors;
    // _selectedIndex = null;

    // print(int.parse("0xFF" + _colors[0]));
    return Container(
      child: Row(
        children: [
          for (var i = 0; i < _colors.length; i++)
            GestureDetector(
              onTap: () {
                if (widget.selectable)
                  setState(() {
                    _selectedIndex = i;
                    widget.setColor(_colors[i]);
                  });
              },
              child: Container(
                height: getProportionateScreenWidth(35),
                width: getProportionateScreenWidth(35),
                margin: EdgeInsets.only(
                  right: getProportionateScreenHeight(12),
                  // top: getProportionateScreenWidth(18),
                  // bottom: getProportionateScreenWidth(18),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(int.parse("0xFF" + _colors[i])),
                        borderRadius: BorderRadius.circular(getProportionateScreenWidth(20)),
                      ),
                    ),
                    Visibility(
                      visible: _selectedIndex == i && widget.selectable,
                      child: Center(
                        child: Icon(
                          Icons.done_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
