import 'package:flutter/material.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/size_config.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen();

  List imageList = [
    "https://media.istockphoto.com/photos/empty-gym-picture-id1132006407?k=20&m=1132006407&s=612x612&w=0&h=Z7nJu8jntywb9jOhvjlCS7lijbU4_hwHcxoVkxv77sg=",
    "https://exceedmasterclass.com/wp-content/uploads/2016/09/nutrition-consultation-fitness-trainer.png",
    "https://cdn.thewirecutter.com/wp-content/uploads/2020/03/onlineworkout-lowres-2x1-1.jpg?auto=webp&quality=75&crop=2:1&width=1024",
    "https://www.theindustry.fashion/wp-content/uploads/2021/10/Gymshark-Heroines-1024x859.jpg",
  ];

  List captionList = [
    "Membership in Kathmandu's Best Gyms",
    "Consult a Nutritionist about your Diet",
    "Online Fitness Classes",
    "Fitness Wears Ecommerce",
  ];

  List titleList = [
    "Gym Membership",
    "Diet Plan",
    "Fitness Classes",
    "Fitness Wears",
  ];

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   // appBar: AppBar(),
    //   body: SafeArea(
    //     child: Column(
    //       // crossAxisAlignment: CrossAxisAlignment.end,
    //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.all(getProportionateScreenHeight(20)),
    //           child: Text(
    //             "Explore Fitness with Healthfix",
    //             style: cusCenterHeadingStyle(),
    //           ),
    //         ),
    //         for (var i = 0; i < 3; i++)
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: ExploreCard(
    //                 imageURL: imageList[i],
    //                 color: colors[i],
    //                 caption: captionList[i],
    //                 text: textList[i]),
    //           ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Fitness with Healthfix", style: cusCenterHeadingStyle(Colors.white)),
        backgroundColor: kPrimaryColor.withOpacity(0.9),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 4/5,
          children: List.generate(
            titleList.length,
            (i) => ExploreCard(
              imageURL: imageList[i],
              caption: captionList[i],
              text: titleList[i],
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    Key key,
    @required this.imageURL,
    @required this.color,
    @required this.caption,
    @required this.text,
  }) : super(key: key);

  final String imageURL;
  final Color color;
  final String caption;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth / 2.2,
      alignment: Alignment.center,
      margin: EdgeInsets.all(getProportionateScreenHeight(8)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.black,
          ],
        ),
        image: DecorationImage(
          image: NetworkImage(imageURL),
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(color, BlendMode.colorBurn),
          opacity: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Wrap(
            // direction: Axis.vertical,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: getProportionateScreenHeight(8)),
                child: Text(
                  text,
                  maxLines: 1,
                  style: cusHeadingStyle(getProportionateScreenHeight(16), Colors.white),
                ),
              ),
              // SizedBox(height: getProportionateScreenHeight()),
              Text(
                caption,
                maxLines: 2,
                style: cusBodyStyle(getProportionateScreenHeight(12), null, Colors.white),
              ),
              // SizedBox(height: getProportionateScreenHeight(8)),
              // cusButton(text: "Learn More"),
            ],
          ),
        ),
      ),
    );
  }
}

class cusButton extends StatelessWidget {
  String text;

  cusButton({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                // height: 30,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                primary: Colors.white,
                // fixedSize: ,
                // textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: Text(
                text ?? 'Learn More',
                style: cusHeadingStyle(16, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
