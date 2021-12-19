import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthfix/components/nothingtoshow_container.dart';
import 'package:healthfix/components/product_card.dart';
import 'package:healthfix/components/rounded_icon_button.dart';
import 'package:healthfix/components/search_field.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/data.dart';
import 'package:healthfix/models/Product.dart';
import 'package:healthfix/screens/product_details/product_details_screen.dart';
import 'package:healthfix/screens/search_result/search_result_screen.dart';
import 'package:healthfix/services/data_streams/category_products_stream.dart';
import 'package:healthfix/services/database/product_database_helper.dart';
import 'package:healthfix/size_config.dart';
import 'package:logger/logger.dart';

class Body extends StatefulWidget {
  final ProductType productType;
  final List<Map> productTypes;

  Body({
    this.productType,
    this.productTypes,
  });

  @override
  _BodyState createState() => _BodyState(categoryProductsStream: CategoryProductsStream(productType));
}

class _BodyState extends State<Body> {
  final CategoryProductsStream categoryProductsStream;

  Map category;
  String _categoryName;
  List<String> _categoryList = [];
  List<String> _subCatList = [];

  _BodyState({@required this.categoryProductsStream});

  @override
  void initState() {
    super.initState();
    categoryProductsStream.init();
    // Fetch Category
    category = widget.productTypes.where((type) => type["product_type"] == widget.productType).first;
    _categoryName = category["title"];

    // Fetch All Product Types
    _categoryList.length = 0;
    widget.productTypes.forEach((pt) {
      _categoryList.add(EnumToString.convertToString(pt['product_type']));
    });

    // Fetch Sub Categories
    fetchSubCategories(_categoryName);

    print(widget.productType);
  }

  @override
  void dispose() {
    super.dispose();
    categoryProductsStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(screenPadding)),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  buildHeadBar(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  // SizedBox(
                  //   height: SizeConfig.screenHeight * 0.13,
                  //   child: buildCategoryBanner(),
                  // ),
                  // SizedBox(
                  //   height: SizeConfig.screenHeight * 0.13,
                  //   child: Container(
                  //     child: Text(
                  //       EnumToString.convertToString(widget.productType),
                  //     ),
                  //   ),
                  // ),

                  // Category Selector
                  Container(
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        elevation: 1,
                        dropdownColor: Colors.white,
                        hint: _categoryName == null
                            ? Text('Dropdown')
                            : Text(
                                _categoryName,
                                style: cusHeadingStyle(22, kPrimaryColor),
                              ),
                        // isExpanded: true,
                        iconSize: 30.0,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: kPrimaryColor.withOpacity(0.6),
                        ),
                        style: TextStyle(color: kPrimaryColor),
                        items: _categoryList.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                                style: cusHeadingLinkStyle,
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(() {
                            fetchCategoryWithName(val);
                            fetchSubCategories(_categoryName);
                            _categoryName = category["title"];
                          });
                        },
                      ),
                    ),
                  ),

                  // Sub-Category
                  Container(
                    height: 20,
                    child: ListView(
                      children: [
                        for (String _subCat in _subCatList)
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Text(
                              _subCat,
                              style: cusBodyStyle(14),
                            ),
                          ),
                      ],
                      scrollDirection: Axis.horizontal,
                    ),
                  ),

                  // SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    // height: SizeConfig.screenHeight * 0.68,
                    child: StreamBuilder<List<String>>(
                      stream: categoryProductsStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<String> productsId = snapshot.data;
                          if (productsId.length == 0) {
                            return Center(
                              child: NothingToShowContainer(
                                secondaryMessage: "No Products in ${EnumToString.convertToString(widget.productType)}",
                              ),
                            );
                          }
                          return buildProductsGrid(productsId);
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          final error = snapshot.error;
                          Logger().w(error.toString());
                        }
                        return Center(
                          child: NothingToShowContainer(
                            iconPath: "assets/icons/network_error.svg",
                            primaryMessage: "Something went wrong",
                            secondaryMessage: "Unable to connect to Database",
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeadBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundedIconButton(
          iconData: Icons.arrow_back_ios,
          press: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(width: 5),
        Expanded(
          child: SearchField(
            onSubmit: (value) async {
              final query = value.toString();
              if (query.length <= 0) return;
              List<String> searchedProductsId;
              try {
                searchedProductsId = await ProductDatabaseHelper().searchInProducts(query.toLowerCase(), productType: widget.productType);
                if (searchedProductsId != null) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultScreen(
                        searchQuery: query,
                        searchResultProductsId: searchedProductsId,
                        searchIn: EnumToString.convertToString(widget.productType),
                      ),
                    ),
                  );
                  await refreshPage();
                } else {
                  throw "Couldn't perform search due to some unknown reason";
                }
              } catch (e) {
                final error = e.toString();
                Logger().e(error);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$error"),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> refreshPage() {
    categoryProductsStream.reload();
    return Future<void>.value();
  }

  Widget buildCategoryBanner() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bannerFromProductType()),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                kPrimaryColor,
                BlendMode.hue,
              ),
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              EnumToString.convertToString(widget.productType),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductsGrid(List<String> productsId) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        // color: Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: productsId.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProductCard(
            productId: productsId[index],
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    productId: productsId[index],
                  ),
                ),
              ).then(
                (_) async {
                  await refreshPage();
                },
              );
            },
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 8,
        ),
        padding: EdgeInsets.symmetric(
          // horizontal: 4,
          vertical: 12,
        ),
      ),
    );
  }

  String bannerFromProductType() {
    switch (widget.productType) {
      case ProductType.Nutrition:
        return "assets/images/electronics_banner.jpg";
      case ProductType.Supplements:
        return "assets/images/books_banner.jpg";
      case ProductType.Food:
        return "assets/images/fashions_banner.jpg";
      case ProductType.Clothing:
        return "assets/images/groceries_banner.jpg";
      case ProductType.Explore:
        return "assets/images/arts_banner.jpg";
      // case ProductType.Others:
      //   return "assets/images/others_banner.jpg";
      default:
        return "assets/images/others_banner.jpg";
    }
  }

  // ProductType nameToProductType() {
  //   switch (_category) {
  //     case "Nutrition":
  //       return ProductType.Nutrition;
  //     case "Supplements":
  //       return ProductType.Supplements;
  //     case "Food":
  //       return ProductType.Food;
  //     case "Clothing":
  //       return ProductType.Clothing;
  //     case "Explore":
  //       return ProductType.Explore;
  //     // case ProductType.Others:
  //     //   return "assets/images/others_banner.jpg";
  //     default:
  //       return ProductType.Nutrition;
  //   }
  // }
  //
  // num indexFromProductType() {
  //   print(widget.productType);
  //   switch (widget.productType) {
  //     case ProductType.Nutrition:
  //       return 0;
  //     case ProductType.Supplements:
  //       return 1;
  //     case ProductType.Clothing:
  //       return 2;
  //     case ProductType.Food:
  //       return 3;
  //     case ProductType.Explore:
  //       return 4;
  //     // case ProductType.Others:
  //     //   return "assets/images/others_banner.jpg";
  //     default:
  //       return 0;
  //   }
  // }

  fetchCategoryWithName(String name) {
    category = widget.productTypes.where((type) => EnumToString.convertToString(type["product_type"]) == name).first;
  }

  fetchSubCategories(String cat) {
    categoryHierarchy.forEach((key, value) {
      if (cat == key) _subCatList = value;
    });
  }
}
