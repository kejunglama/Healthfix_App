import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthfix/constants.dart';
import 'package:healthfix/screens/cart/cart_screen.dart';
import 'package:healthfix/screens/category/category_screen.dart';
import 'package:healthfix/screens/explore_fitness/explore_screen.dart';

import '../../size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;
  PageController _tabsPageController;

  @override
  void initState() {
    // TODO: implement initState
    _tabsPageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabsPageController.dispose();
  }

  void _onItemTapped(int index) {
    // print(index);
    _tabsPageController.animateToPage(
      index,
      duration: Duration(seconds: 1),
      curve: Curves.easeOutCubic,
    );
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
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedIndex = num;
                });
              },
              children: [
                Body(goToCategory),
                ExploreScreen(),
                CategoryScreen(),
                CartScreen(),
              ]),
          // drawer: HomeScreenDrawer(),
          bottomNavigationBar: buildBottomNavigationBar(),
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        // BottomNavigationBarItem(
        //   icon: SvgPicture.asset("assets/icons/app/icons-shop.svg"),
        //   activeIcon: SvgPicture.asset("assets/icons/app/icons-filled-shop.svg"),
        //   label: 'Shop',
        //   // backgroundColor: Colors.pink,
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.loyalty_outlined),
          activeIcon: Icon(Icons.loyalty),
          label: 'Explore',

          // backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          activeIcon: Icon(Icons.grid_view_rounded),
          label: 'Categories',
          // backgroundColor: Colors.pink,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          activeIcon: Icon(Icons.shopping_bag_rounded),
          label: 'Cart',
          // backgroundColor: Colors.purple,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.cyan,
      // showUnselectedLabels: false,
      // showSelectedLabels: false,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }

  void goToCategory() {
    setState(() {
      _selectedIndex = 2;
      _onItemTapped(2);
    });
  }
}
