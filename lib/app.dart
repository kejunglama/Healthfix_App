import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:healthfix/wrappers/authentification_wrapper.dart';
import 'package:page_transition/page_transition.dart';

import 'constants.dart';
import 'theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: AnimatedSplashScreen(
          splash: 'assets/logo/hf-logo-only.png',
          duration: 1000,
          backgroundColor: kPrimaryColor,
          nextScreen: AuthentificationWrapper(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        )
        //home: AuthentificationWrapper(),
        );
  }
}
