import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/champs_teams_favorite_controller.dart';
import 'package:champs2022rank1ng/src/models/champs_top_teams.dart';
import 'package:champs2022rank1ng/src/models/chmaps_custome_models.dart';
import 'package:champs2022rank1ng/src/widgets/champs_team_fav_name_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChampsFavoriteTeams extends StatefulWidget {
  const ChampsFavoriteTeams({Key? key}) : super(key: key);

  @override
  State<ChampsFavoriteTeams> createState() => _ChampsFavoriteTeamsState();
}

class _ChampsFavoriteTeamsState extends State<ChampsFavoriteTeams> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greyFourth,
          centerTitle: true,
          title: const Text(
            'Favorite Teams',
            style: kAppbarTextStyle,
          ),
        ),
        body: Consumer<FavoriteContorller>(builder: (context, model, child) {
          if (model.favoriteResponse.modelStatus ==
              UpcomingMatchStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (model.favoriteResponse.modelStatus ==
              UpcomingMatchStatus.idle) {
            List<TopTeam> _favTeams = model.favoriteResponse.data;
            return _favTeams.isEmpty
                ? const Center(
                    child: Text("No Favorites Yet!"),
                  )
                : ListView(
                    children: _favTeams
                        .map((favTeam) => TopFavTeamFavNameOddImage(
                          caller: Caller.fav,
                            team: favTeam,
                            onPressed: () async {
                              model.deleteTeam(favTeam.flag);
                            }))
                        .toList());
          } else {
            return Center(
              child: Text(model.favoriteResponse.error!.message),
            );
          }
        }));
  }
}
