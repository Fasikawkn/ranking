import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/champs_teams_favorite_controller.dart';
import 'package:champs2022rank1ng/src/controllers/z_champs_controllers.dart';
import 'package:champs2022rank1ng/src/models/champs_top_teams.dart';
import 'package:champs2022rank1ng/src/models/chmaps_custome_models.dart';
import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:champs2022rank1ng/src/widgets/champs_team_fav_name_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChampsTopTeams extends StatefulWidget {
  const ChampsTopTeams({Key? key}) : super(key: key);

  @override
  State<ChampsTopTeams> createState() => _ChampsTopTeamsState();
}

class _ChampsTopTeamsState extends State<ChampsTopTeams> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Add Your Code here.
      _getTopTeams();
    });
  }

  _getTopTeams() async {
    final _matchesResponse =
        Provider.of<UpcomingMatchModel>(context, listen: false).matchReponse;
    if (_matchesResponse.data is List) {
      Provider.of<UpcomingMatchModel>(context, listen: false)
          .getTopTeams(_matchesResponse.data);
    }
  }

  late FavoriteContorller favoriteController;

  @override
  Widget build(BuildContext context) {
    favoriteController =
        Provider.of<FavoriteContorller>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyFourth,
        centerTitle: true,
        title: const Text(
          "Top Teams",
          style: kAppbarTextStyle,
        ),
      ),
      body: Consumer<UpcomingMatchModel>(builder: (context, model, child) {
        if (model.topTeamsReponse.modelStatus == UpcomingMatchStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (model.topTeamsReponse.modelStatus ==
            UpcomingMatchStatus.idle) {
          // debugPrint("Top Teams are ${model.topTeamsReponse.data}");
          List<TopTeam> _topTeams = model.topTeamsReponse.data;
          return ListView(
            children: _topTeams
                .map(
                  (topTeam) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChampsTeamDetail(
                              team: topTeam.team!, game: topTeam.game!),
                        ),
                      );
                    },
                    child: TopFavTeamFavNameOddImage(
                      caller: Caller.top,
                      team: topTeam,
                      unFavorite: () async {
                        favoriteController.deleteTeam(topTeam.flag);
                      },
                      onPressed: () async {
                        favoriteController.insertTeam(topTeam);
                      },
                    ),
                  ),
                )
                .toList(),
          );
        } else {
          return Center(
            child: Text(model.topTeamsReponse.error!.message),
          );
        }
      }),
    );
  }
}
