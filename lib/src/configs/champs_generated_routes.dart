import 'package:champs2022rank1ng/src/views/champs_homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    }
    return MaterialPageRoute(
      builder: (context) => const HomePage(),
    );
  }
}
