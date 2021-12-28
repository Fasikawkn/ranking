import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/champs_upcoming_match_controller.dart';
import 'package:champs2022rank1ng/src/controllers/z_champs_controllers.dart';
import 'package:champs2022rank1ng/src/services/z_champs_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'src/controllers/champs_teams_favorite_controller.dart';
import 'src/db/db_helper.dart';

void main() {
  final UpcomingMatchRepository _upcomingMatchRepository =
      UpcomingMatchRepository(
          dataProvider: UpcomingGameDataProvider(httpClient: http.Client()));
  runApp(ChampsRank(
    repository: _upcomingMatchRepository,
  ));
}

class ChampsRank extends StatelessWidget {
  const ChampsRank({required this.repository, Key? key}) : super(key: key);
  final UpcomingMatchRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UpcomingMatchModel>(
            create: (context) => UpcomingMatchModel(repository: repository)
              ..getUpcomingMatches('today')),
        ChangeNotifierProvider<TeamPreviosGameController>(
            create: (context) =>
                TeamPreviosGameController(repository: repository)),
        ChangeNotifierProvider<DBHelper>(
          create: (context) => DBHelper(),
        ),
        ChangeNotifierProxyProvider<DBHelper, FavoriteContorller>(
          create: (context) => FavoriteContorller( null, []),
          update: (context, db, previous) => FavoriteContorller(
             db,
             previous!.items,
          ),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: createMaterialColor(primaryColor),
        ),
        onGenerateRoute: AppRoute.generateRoute,
      ),
    );
  }
}
