import 'package:champs2022rank1ng/src/configs/champs_custom_functions.dart';
import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/z_champs_controllers.dart';
import 'package:champs2022rank1ng/src/models/champs_game_odd.dart';
import 'package:champs2022rank1ng/src/models/champs_pregame_model.dart';
import 'package:champs2022rank1ng/src/widgets/z_champs_widgets.dart';
import 'package:flutter/cupertino.dart';
// import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChampsTeamLabel extends StatelessWidget {
  ChampsTeamLabel({
    required this.game,
    Key? key,
  }) : super(key: key);

  final UpComingGame game;
  late UpcomingMatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    matchModel = Provider.of<UpcomingMatchModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: greyColor,
          ),
        ),
      ),
      
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChampsTeamPlayTimeDate(
                date: CustomFunctions.getDate(game.time),
                time: CustomFunctions.getTime(game.time),
              ),
              FutureBuilder<GameOdd>(
                  future: matchModel.getOdd(game.gameId),
                  builder: (context, snapshots) {
                    return Row(
                      children: [
                        ChampsTeamOddLabel(
                          name: game.home.name,
                          odd: snapshots.hasData
                              ? Text(
                                  snapshots.data!.homeOd == '0'? "1.01": snapshots.data!.homeOd,
                                  style: kAppbarTextStyle.copyWith(
                                      color: Colors.black),
                                )
                              : const SpinKitThreeBounce(
                                  color: primaryColor,
                                  size: 20.0,
                                ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        ChampsTeamOddLabel(
                          name: game.away.name,
                          odd: snapshots.hasData
                              ? Text(
                                    snapshots.data!.awayOd == '0'? "1.04": snapshots.data!.awayOd,
                                  style: kAppbarTextStyle.copyWith(
                                      color: Colors.black),
                                )
                              : const SpinKitThreeBounce(
                                  color: primaryColor,
                                  size: 20.0,
                                ),
                        ),
                      ],
                    );
                  },
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}
