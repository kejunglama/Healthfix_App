import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthfix/constants.dart';

import '../../size_config.dart';
import 'components/body.dart';
import 'components/home_screen_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
        statusBarColor: kPrimaryColor,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Body(),
        drawer: HomeScreenDrawer(),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/app-bar/icons-home.svg"),
          activeIcon: SvgPicture.asset("assets/icons/app-bar/icons-filled-home.svg"),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/app-bar/icons-shop.svg"),
          activeIcon: SvgPicture.asset("assets/icons/app-bar/icons-filled-shop.svg"),
          label: 'Shop',
          // backgroundColor: Colors.pink,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/app-bar/icons-explore.svg"),
          activeIcon: SvgPicture.asset("assets/icons/app-bar/icons-filled-explore.svg"),
          label: 'Explore',
          // backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/app-bar/icons-category.svg"),
          activeIcon: SvgPicture.asset("assets/icons/app-bar/icons-filled-category.svg"),
          label: 'Categories',
          // backgroundColor: Colors.pink,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/app-bar/icons-cart.svg"),
          activeIcon: SvgPicture.asset("assets/icons/app-bar/icons-filled-cart.svg"),
          label: 'Cart',
          // backgroundColor: Colors.purple,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.cyan,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}
