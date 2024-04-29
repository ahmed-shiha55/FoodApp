import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodapp/screens/home.dart';
import 'package:foodapp/screens/search.dart';
import 'package:foodapp/screens/fliterbycountry.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNAv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [Home(), SearchScreen(), Fliter()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: Color.fromARGB(255, 250, 139, 28),
          inactiveColorPrimary: const Color.fromARGB(255, 214, 214, 230),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.search),
          title: ("Search"),
          activeColorPrimary: Color.fromARGB(255, 250, 139, 28),
          inactiveColorPrimary: const Color.fromARGB(255, 214, 214, 230),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.color_filter),
          title: ("Settings"),
          activeColorPrimary: Color.fromARGB(255, 250, 139, 28),
          inactiveColorPrimary: const Color.fromARGB(255, 214, 214, 230),
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.black, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        //borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style13, // Choose the nav bar style with this property.
    );
  }
}
