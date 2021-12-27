import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/views/champs_top_teams.dart';
import 'package:champs2022rank1ng/src/views/champs_favorite_team.dart';
import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:champs2022rank1ng/src/widgets/common/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Home extends StatefulWidget {
  static const routeName = "/champs/mainHome";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  int _selectedIndex = 0;
  List<Widget> _buildScreens() {
    return const [
      HomePage(),
      ChampsTopTeams(),
      ChampsFavoriteTeams(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/home.svg',
          color: _selectedIndex == 0 ? primaryColor : whiteColor,
        ),
        title: ("Home"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.star),
        title: ("Settings"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/top_teams.svg',
            color: _selectedIndex == 2 ? primaryColor : whiteColor),
        title: ("Settings"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: whiteColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
      context,
      controller: _controller,
      screens: _buildScreens(),
      itemCount: 3,
      confineInSafeArea: true,
      backgroundColor: greyFourth, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      customWidget: CustomNavBarWidget(
        // Your custom widget goes here
        items: _navBarsItems(),
        selectedIndex: _controller.index,
        onItemSelected: (index) {
          setState(() {
            _controller.index =
                index; // NOTE: THIS IS CRITICAL!! Don't miss it!
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
