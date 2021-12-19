import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/data.dart';
import 'package:healthfix/size_config.dart';

class Body extends StatelessWidget {
  Body();

  final catKey_nutri = GlobalKey();
  final catKey_suppl = GlobalKey();
  final catKey_foods = GlobalKey();
  final catKey_cloth = GlobalKey();
  final catKey_explr = GlobalKey();

  Future scrollToCat([GlobalKey key]) async {
    final context = key.currentContext;
    await Scrollable.ensureVisible(context, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    List keyList = [
      catKey_nutri,
      catKey_suppl,
      catKey_foods,
      catKey_cloth,
      catKey_explr,
    ];


    return SafeArea(
      child: Row(
        children: [
          CategoryList(productCategories, scrollToCat, keyList),
          CategoryHierarchyList(categoryHierarchy, keyList),
        ],
      ),
    );
  }
}

class CategoryHierarchyList extends StatelessWidget {
  List keyList;
  Map categoryHierarchy;

  CategoryHierarchyList(this.categoryHierarchy, this.keyList);

  @override
  Widget build(BuildContext context) {
    Map _ch = categoryHierarchy;
    print(_ch.keys);
    var i = 0;

    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var entry in _ch.entries)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    key: keyList[i++],
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(40, 20, 20, 10),
                    child: Text(entry.key, style: cusHeadingStyle(17, kPrimaryColor)),
                  ),
                  for (var arrValue in entry.value)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Text(
                        arrValue,
                        style: cusBodyStyle(15),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  List categories;
  List keyList;
  Future Function([GlobalKey key]) scrollToCat;

  String ICON_KEY = "icon";
  String TITLE_KEY = "title";

  CategoryList(this.categories, this.scrollToCat, this.keyList);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        border: Border(
          right: BorderSide(width: 1.0, color: Colors.grey.shade100),
        ),
        color: Colors.white,
      ),
      child: Container(
        width: SizeConfig.screenWidth * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < categories.length; i++)
              Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    scrollToCat(keyList[i]);
                  },
                  child: Center(
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(bottom: 20),
                            child: SvgPicture.asset(categories[i][ICON_KEY], color: kPrimaryColor),
                          ),
                          Text(
                            categories[i][TITLE_KEY],
                            style: cusHeadingStyle(14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
