import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChampsRank());
}

class ChampsRank extends StatelessWidget {
  const ChampsRank({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: createMaterialColor(primaryColor),
      ),
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}