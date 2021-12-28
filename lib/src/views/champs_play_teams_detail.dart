import 'package:champs2022rank1ng/src/configs/champs_custom_functions.dart';
import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/z_champs_controllers.dart';
import 'package:champs2022rank1ng/src/models/champs_game_odd.dart';
import 'package:champs2022rank1ng/src/models/champs_pregame_model.dart';
import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:champs2022rank1ng/src/widgets/champs_team_odd_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChampsPlayTeamsDetail extends StatelessWidget {
  static const routeName = "/champs/teamsdetail";
  ChampsPlayTeamsDetail({required this.game, Key? key}) : super(key: key);
  final UpComingGame game;
  late UpcomingMatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    matchModel = Provider.of<UpcomingMatchModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyFourth,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Match",
          style: kAppbarTextStyle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: greyFirst,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Text(game.league.name,
                    textAlign: TextAlign.center, style: kLeagueNameLabelStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(CustomFunctions.getDate(game.time),
                        style: kLeagueGameTimeLabelStyle),
                    const SizedBox(width: 10.0),
                    Text(CustomFunctions.getTime(game.time),
                        style: kLeagueGameTimeLabelStyle)
                  ],
                )
              ],
            ),
          ),
          if (game.score != null)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(game.score!,
                      style: const TextStyle(
                        color: greyFourth,
                        fontWeight: FontWeight.w900,
                        fontSize: 40.0,
                        fontFamily: "Open Sans",
                      ))
                ],
              ),
            ),
          SizedBox(height: size.height * 0.03),
          FutureBuilder<GameOdd>(
              future: matchModel.getOdd(game.gameId),
              builder: (context, snapshots) {
                return Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                         ChampsTeamDetail(
                                          team: game.home,
                                          game: game
                                        ),
                                  ),
                                );
                              },
                              child: DetailTeamNameOddLabel(
                                  name: game.home.name,
                                  odd: snapshots.hasData
                                      ? Text(
                                          "${snapshots.data!.homeOd}",
                                          style: kAppbarTextStyle.copyWith(
                                              color: Colors.black),
                                        )
                                      : const SpinKitThreeBounce(
                                          color: primaryColor,
                                          size: 20.0,
                                        )),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                         ChampsTeamDetail(
                                          team: game.away,
                                          game: game,
                                        ),
                                  ),
                                );
                              },
                              child: DetailTeamNameOddLabel(
                                name: game.away.name,
                                odd: snapshots.hasData
                                    ? Text(
                                        "${snapshots.data!.awayOd}",
                                        style: kAppbarTextStyle.copyWith(
                                            color: Colors.black),
                                      )
                                    : const SpinKitThreeBounce(
                                        color: primaryColor,
                                        size: 20.0,
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChampsTeamOddLabel(
                            name: 'Draw',
                            odd: snapshots.hasData
                                ? Text(
                                    "${snapshots.data!.drawOd}",
                                    style: kAppbarTextStyle.copyWith(
                                        color: Colors.black),
                                  )
                                : const SpinKitThreeBounce(
                                    color: primaryColor,
                                    size: 20.0,
                                  )),
                      ],
                    )
                  ],
                );
              })
        ],
      ),
    );
  }
}

class DetailTeamNameOddLabel extends StatelessWidget {
  const DetailTeamNameOddLabel(
      {Key? key, required this.name, required this.odd})
      : super(key: key);

  final String name;
  final Widget odd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: lightGreen, borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
                color: greyFourth, fontWeight: FontWeight.w700, fontSize: 16.0),
          ),
          odd
        ],
      ),
    );
  }
}
