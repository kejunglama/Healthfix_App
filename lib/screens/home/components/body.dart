import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/models/Product.dart';
import 'package:healthfix/screens/cart/cart_screen.dart';
import 'package:healthfix/screens/category_products/category_products_screen.dart';
import 'package:healthfix/screens/home/components/DietPlannerBanner.dart';
import 'package:healthfix/screens/home/components/our_feature_section.dart';
import 'package:healthfix/screens/home/components/top_brands_section.dart';
import 'package:healthfix/screens/home/components/top_category_card.dart';
import 'package:healthfix/screens/product_details/product_details_screen.dart';
import 'package:healthfix/screens/search_result/search_result_screen.dart';
import 'package:healthfix/services/authentification/authentification_service.dart';
import 'package:healthfix/services/data_streams/all_products_stream.dart';
import 'package:healthfix/services/data_streams/favourite_products_stream.dart';
import 'package:healthfix/services/data_streams/featured_products_stream.dart';
import 'package:healthfix/services/database/product_database_helper.dart';
import 'package:healthfix/size_config.dart';
import 'package:logger/logger.dart';

import '../../../utils.dart';
import '../components/home_header.dart';
import 'home_ads_banner.dart';
import 'home_ongoing_offers.dart';
import 'product_type_box.dart';
import 'products_section.dart';

const String ICON_KEY = "icon";
const String TITLE_KEY = "title";
const String PRODUCT_TYPE_KEY = "product_type";

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final productCategories = <Map>[
    <String, dynamic>{
      ICON_KEY: "assets/icons/app/icons-dumbell.svg",
      TITLE_KEY: "Sports Nutrition",
      PRODUCT_TYPE_KEY: ProductType.Nutrition,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/app/icons-suppliment.svg",
      TITLE_KEY: "Vitamin/Supplement",
      PRODUCT_TYPE_KEY: ProductType.Supplements,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/app/icons-veg.svg",
      TITLE_KEY: "Health Food & Drink",
      PRODUCT_TYPE_KEY: ProductType.Food,
    },
    // <String, dynamic>{
    //   ICON_KEY: "assets/icons/app/icons-.svg",
    //   TITLE_KEY: "Groceries",
    //   PRODUCT_TYPE_KEY: ProductType.Groceries,
    // },
    <String, dynamic>{
      ICON_KEY: "assets/icons/app/icons-shop.svg",
      TITLE_KEY: "Clothing Apparel",
      PRODUCT_TYPE_KEY: ProductType.Clothing,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/app/icons-explore.svg",
      TITLE_KEY: "Explore Fitness",
      PRODUCT_TYPE_KEY: ProductType.Explore,
    },
  ];

  final List<String> adsBannerImagesList = [
    'https://firebasestorage.googleapis.com/v0/b/siteux-healthfix.appspot.com/o/offer_banners%2FHF-Banner-1.jpg?alt=media&token=2b8a7851-6276-4a7d-8468-1baf79e45882',
    'https://firebasestorage.googleapis.com/v0/b/siteux-healthfix.appspot.com/o/offer_banners%2FHF-Banner-3.jpg?alt=media&token=8d9a44c2-94d3-4b5d-95b5-1ccc0ebb1020',
    'https://firebasestorage.googleapis.com/v0/b/siteux-healthfix.appspot.com/o/offer_banners%2FHF-Banner-2.jpg?alt=media&token=cb242636-d7de-4b0f-adfb-75fbd2f059e6'
  ];

  final List<String> offerImagesList = [
    'https://i.pinimg.com/originals/a2/af/48/a2af4856f5bc2272554efa4f19502ebf.jpg',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/black-gym-discount-instagram-post-template-design-4fd8234005349d24e1e91fb6ce152158_screen.jpg?ts=1561443287',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9QSlHbGPoLRbf3XbCpDbtOMKP3_blu9IZQAFlx2YbMIiT7uuIqMVIZMyhFbrful948RE&usqp=CAU',
  ];

  final List<String> topCategoriesList = [
    'https://firebasestorage.googleapis.com/v0/b/siteux-healthfix.appspot.com/o/top_categories%2FTOPCAT-2.png?alt=media&token=a6b3e4d0-2374-4dcb-80e0-03e52545f8ab',
    'https://firebasestorage.googleapis.com/v0/b/siteux-healthfix.appspot.com/o/top_categories%2FTOPCAT-1.png?alt=media&token=e9c7c16c-2899-4f1a-a0d3-407436f9e586',
  ];

  final List<String> topBrandsList = [
    'https://i.pinimg.com/originals/49/1b/23/491b2363ff6e7272739a9a9215f273ac.jpg',
    'https://media.designrush.com/inspiration_images/134805/conversions/_1512076803_93_Nike-preview.jpg',
    'https://image.shutterstock.com/image-photo/kiev-ukraine-march-31-2015-260nw-275940803.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Reebok_2019_logo.svg/1200px-Reebok_2019_logo.svg.png',
    'https://cdn.shopify.com/s/files/1/1367/5207/files/gymshark_social_banner_1200x1200.jpg?v=1549554503',
    'https://1000logos.net/wp-content/uploads/2020/09/Optimum-Nutrition-Logo.png',
  ];

  final FavouriteProductsStream favouriteProductsStream = FavouriteProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();
  final FeaturedProductsStream featuredProductsStream = FeaturedProductsStream();

  @override
  void initState() {
    super.initState();
    favouriteProductsStream.init();
    allProductsStream.init();
    featuredProductsStream.init();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();
    featuredProductsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(featuredProductsStream.stream);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            // padding: EdgeInsets.symmetric(
            //     horizontal: getProportionateScreenWidth(screenPadding)),
            // child: Column(

            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(height: getProportionateScreenHeight(15)),

              HomeHeader(
                onSearchSubmitted: (value) async {
                  final query = value.toString();
                  if (query.length <= 0) return;
                  List<String> searchedProductsId;
                  try {
                    searchedProductsId = await ProductDatabaseHelper().searchInProducts(query.toLowerCase());
                    if (searchedProductsId != null) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResultScreen(
                            searchQuery: query,
                            searchResultProductsId: searchedProductsId,
                            searchIn: "All Products",
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
                onCartButtonPressed: () async {
                  bool allowed = AuthentificationService().currentUserVerified;
                  if (!allowed) {
                    final reverify = await showConfirmationDialog(
                        context, "You haven't verified your email address. This action is only allowed for verified users.",
                        positiveResponse: "Resend verification email", negativeResponse: "Go back");
                    if (reverify) {
                      final future = AuthentificationService().sendVerificationEmailToCurrentUser();
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return FutureProgressDialog(
                            future,
                            message: Text("Resending verification email"),
                          );
                        },
                      );
                    }
                    return;
                  }
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                  await refreshPage();
                },
              ),

              // Section - Offer Banners
              Ads_Banners(adsBannerImagesList),

              SizedBox(height: getProportionateScreenHeight(5)),

              // Section - Product Category
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      // vertical: 8.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category",
                            style: cusHeadingStyle(),
                          ),
                          Text(
                            "See More >",
                            style: cusHeadingLinkStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.13,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        // vertical: 4,
                        horizontal: 10,
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: [
                          ...List.generate(
                            productCategories.length,
                            (index) {
                              return ProductTypeBox(
                                icon: productCategories[index][ICON_KEY],
                                title: productCategories[index][TITLE_KEY],
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryProductsScreen(
                                        productType: productCategories[index][PRODUCT_TYPE_KEY],
                                        productTypes: productCategories,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // SizedBox(height: getProportionateScreenHeight(20)),
              // SizedBox(
              //   height: SizeConfig.screenHeight * 0.5,
              //   child: ProductsSection(
              //     sectionTitle: "Products You Like",
              //     productsStreamController: favouriteProductsStream,
              //     emptyListMessage: "Add Product to Favourites",
              //     onProductCardTapped: onProductCardTapped,
              //   ),
              // ),
              // SizedBox(height: getProportionateScreenHeight(20)),

              // Section - Explore Products
              Container(
                height: SizeConfig.screenHeight * 0.36,
                child: ProductsSection(
                  sectionTitle: "Explore All Products",
                  productsStreamController: allProductsStream,
                  emptyListMessage: "Looks like all Stores are closed",
                  onProductCardTapped: onProductCardTapped,
                ),
              ),

              // Section - Ongoing Offers
              OngoingOffers(offerImagesList),

              // Section - Trending Products
              Container(
                height: SizeConfig.screenHeight * 0.36,
                child: ProductsSection(
                  sectionTitle: "Trending Products",
                  productsStreamController: featuredProductsStream,
                  emptyListMessage: "Looks like all Stores are closed",
                  onProductCardTapped: onProductCardTapped,
                ),
              ),

              // Top categories
              // Container(
              //   color: kPrimaryColor.withOpacity(0.1),
              //   child: Column(
              //     children: [
              //       SizedBox(height: getProportionateScreenHeight(12)),
              //       Text(
              //         "Top Categories",
              //         style: cusCenterHeadingStyle(),
              //       ),
              //       // SizedBox(height: getProportionateScreenHeight(10)),
              //
              //       // SizedBox(
              //       //   height: 532,
              //       //   child: GridView.count(
              //       //     crossAxisCount: 2,
              //       //     children: List.generate(
              //       //       4,
              //       //       (index) => Container(
              //       //         height: 100,
              //       //         child: TopCategoryCard(),
              //       //       ),
              //       //     ),
              //       //   ),
              //       // ),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           SizedBox(height: getProportionateScreenHeight(20)),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               TopCategoryCard(topCategoriesList[0]),
              //               SizedBox(width: getProportionateScreenWidth(20)),
              //               TopCategoryCard(topCategoriesList[1]),
              //             ],
              //           ),
              //           SizedBox(height: getProportionateScreenHeight(20)),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               TopCategoryCard(topCategoriesList[1]),
              //               SizedBox(width: getProportionateScreenWidth(20)),
              //               TopCategoryCard(topCategoriesList[0]),
              //             ],
              //           ),
              //           SizedBox(height: getProportionateScreenHeight(20)),
              //         ],
              //       )
              //     ],
              //   ),
              // ),

              // Diet Plan Banner

              DietPlanBanner(),

              // Section - Top Brands
              TopBrandsSection(topBrandsList),

              // Section - Our Features
              OurFeaturesSection(),

              // SizedBox(height: getProportionateScreenHeight(80)),
            ],
          ),
        ),
      ),
      // ),
    );

  }

  Future<void> refreshPage() {
    favouriteProductsStream.reload();
    allProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productId: productId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}

