import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/size_config.dart';

class OngoingOffers extends StatelessWidget {
  final List<String> offerImagesList;

   // OngoingOffers({key, this.offerImagesList}) : super(key: key);
  OngoingOffers(this.offerImagesList);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ongoing Offers | ",
                style: cusCenterHeadingStyle(),
              ),
              Text(
                "November Deals",
                style: cusCenterHeadingAccentStyle,
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(8)),
          Container(
            // color: kPrimaryColor,
            child: Container(
              margin: EdgeInsets.all(8),
              child: CarouselSlider.builder(
                itemCount: offerImagesList.length,
                options: CarouselOptions(
                  viewportFraction: 0.55,
                  // enlargeCenterPage: true,
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  reverse: false,
                  // aspectRatio: 1,
                ),
                itemBuilder: (context, i, id) {
                  //for onTap to redirect to another screen
                  return GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        offerImagesList[i],
                        // width: 300,
                        // height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      var url = offerImagesList[i];
                      print(url.toString());
                    },
                  );
                },
              ),
            ),
          ),
          // SizedBox(height: getProportionateScreenHeight(15)),
        ],
      ),
    );
  }
}
