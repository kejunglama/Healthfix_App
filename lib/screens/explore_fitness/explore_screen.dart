import 'package:flutter/material.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/size_config.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen();

  List imageList = [
    "https://media.istockphoto.com/photos/empty-gym-picture-id1132006407?k=20&m=1132006407&s=612x612&w=0&h=Z7nJu8jntywb9jOhvjlCS7lijbU4_hwHcxoVkxv77sg=",
    "https://cdn.thewirecutter.com/wp-content/uploads/2020/03/onlineworkout-lowres-2x1-1.jpg?auto=webp&quality=75&crop=2:1&width=1024",
    "https://exceedmasterclass.com/wp-content/uploads/2016/09/nutrition-consultation-fitness-trainer.png",
  ];

  List captionList = [
    "Membership in Kathmandu's Best Gyms",
    "Consult a Nutritionist about your Diet",
    "Online Fitness Classes",
  ];

  List textList = [
    "Gym Membership",
    "Nutrition Consultation",
    "Fitness Classes",
  ];

  List colors = [
    Colors.red.withOpacity(0.7),
    Colors.cyan.withOpacity(0.7),
    Colors.amber.withOpacity(0.7),
  ];

  @override
  Widget build(BuildContext context) {
    double screenW = SizeConfig.screenWidth - 16;
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(20)),
              child: Text(
                "Explore Fitness with Healthfix",
                style: cusCenterHeadingStyle(),
              ),
            ),
            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExploreCard(
                    imageURL: imageList[i],
                    color: colors[i],
                    caption: captionList[i],
                    text: textList[i]),
              ),
          ],
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
      width: SizeConfig.screenWidth - 16,
      height: (SizeConfig.screenHeight) / 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageURL),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(color, BlendMode.colorBurn),
          opacity: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                caption,
                style: cusHeadingStyle(20, Colors.white, true),
              ),
              // SizedBox(height: getProportionateScreenHeight(8)),
              Text(
                text,
                style: cusHeadingStyle(30, Colors.white, true),
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              cusButton(text: "Learn More"),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
