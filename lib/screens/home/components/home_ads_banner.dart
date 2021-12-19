import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Ads_Banners extends StatelessWidget {
  List imagesList;

  Ads_Banners(this.imagesList, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var imagesList;
    return Container(
      // color: kPrimaryColor,
      child: Container(
        // margin: EdgeInsets.all(8),
        child: CarouselSlider.builder(
          itemCount: imagesList.length,
          options: CarouselOptions(
            viewportFraction: 0.9,
            // enlargeCenterPage: true,
            height: 150,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            reverse: false,
            aspectRatio: 5.0,
          ),
          itemBuilder: (context, i, id) {
            //for onTap to redirect to another screen
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(color: Colors.white,)
                ),
                //ClipRRect for image border radius
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    imagesList[i],
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                var url = imagesList[i];
                print(url.toString());
              },
            );
          },
        ),
      ),
    );
  }
}
