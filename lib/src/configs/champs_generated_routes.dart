import 'package:champs2022rank1ng/src/views/champs_home.dart';
import 'package:champs2022rank1ng/src/views/champs_homepage.dart';
import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == "/") {
      return PageTransition(
        child: const Home(),
        type: PageTransitionType.leftToRight,
        settings: settings,
      );
    }
    else if (settings.name == ChampsPlayTeamsDetail.routeName) {
      return PageTransition(
        child: const ChampsPlayTeamsDetail(),
        type: PageTransitionType.leftToRight,
        settings: settings,
      );
    }
     else if (settings.name == ChampsTeamDetail.routeName) {
      return PageTransition(
        child: const ChampsTeamDetail(),
        type: PageTransitionType.leftToRight,
        settings: settings,
      );
    }
    return  PageTransition(
        child: const HomePage(),
        type: PageTransitionType.leftToRight,
        settings: settings,
      );
  }
}
