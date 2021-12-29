import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/z_champs_controllers.dart';
import 'package:champs2022rank1ng/src/models/champs_pregame_model.dart';
import 'package:champs2022rank1ng/src/models/chmaps_custome_models.dart';
import 'package:champs2022rank1ng/src/widgets/z_champs_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChampsTeamDetail extends StatefulWidget {
  static const routeName = "/chaps/teamDetail";
  const ChampsTeamDetail({required this.game, required this.team, Key? key})
      : super(key: key);
  final Team team;
  final UpComingGame game;

  @override
  State<ChampsTeamDetail> createState() => _ChampsTeamDetailState();
}

class _ChampsTeamDetailState extends State<ChampsTeamDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Add Your Code here.
      _getTeamPreviousgames();
    });
  }

  _getTeamPreviousgames() async {
    final model =
        Provider.of<TeamPreviosGameController>(context, listen: false);
    await model.getTeamPreviousGames(widget.team.id).whenComplete(() async {
      UpcomingMatchReponse _response = model.matchReponse;
      List<UpComingGame> games = _response.data;
      model.getOdds(games, widget.team, widget.game);
    });
  }
late TeamPreviosGameController teamPreviosGameController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    teamPreviosGameController = Provider.of<TeamPreviosGameController>(context);
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
          'Team',
          style: kAppbarTextStyle,
        ),
      ),
      
      body: SingleChildScrollView(
        child: Consumer<TeamPreviosGameController>(
            builder: (context, model, child) {
          if (model.matchReponse.modelStatus == UpcomingMatchStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (model.matchReponse.modelStatus ==
              UpcomingMatchStatus.idle) {
            List<UpComingGame> _previousGames = model.matchReponse.data;
             List<double> _odds = model.oddsResponse.data;
            return Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  TeamFavNameOddImage(
                   game: widget.game,
                   team: widget.team,
                    
                    onPressed: () {},
                  ),
                  // Consumer<TeamPreviosGameController>(
                  //     builder: (context, model, child) {
                  //   List<double> _odds = model.oddsResponse.data;
                  //   debugPrint("THe odds Are ${model.oddsResponse.data}");
                 
        
                     Container(
                        height: 170.0,
                        width: size.width,
                        color: greyFourth,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: model.oddsResponse.modelStatus ==
                                UpcomingMatchStatus.loading
                            ? const SpinKitFadingCircle(
                                color: whiteColor,
                                size: 20.0,
                              )
                            : model.oddsResponse.modelStatus ==
                                    UpcomingMatchStatus.idle
                                ? SfSparkLineChart(
                                    //Enable the trackball
                                    // trackball: const SparkChartTrackball(
                                    //     activationMode: SparkChartActivationMode.tap),
                                    //Enable marker
                                    marker: const SparkChartMarker(
                                        color: whiteColor,
                                        borderColor: whiteColor,
                                        displayMode:
                                            SparkChartMarkerDisplayMode.all),
                                    //Enable data label
                                    labelDisplayMode:
                                        SparkChartLabelDisplayMode.last,
                                    axisLineColor: greyFourth,
                                    color: primaryColor,
                                    labelStyle: const TextStyle(
                                        color: whiteColor,
                                        fontFamily: "Open Sans",
                                        fontSize: 16.0),
                                    data: model.oddsResponse.data,
                                  )
                                : const Text("Failed to load graph",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0))),
                  // }),
                  ExpansionTile(
                      title: const Text(
                        "Past odds",
                        style: TextStyle(
                            color: greyFourth,
                            fontFamily: "Open Sans",
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700),
                      ),
                      initiallyExpanded: true,
                      children: _previousGames == null
                          ? []
                          : _previousGames
                              .map((game) => ChampsTeamLabel(
                                    game: game,
                                  ))
                              .toList())
                ],
              ),
            );
          } else {
            return Center(
              child: Text(model.matchReponse.error!.message),
            );
          }
        }),
      ),
    );
  }

  List<Widget> _pastGames() {
    return [];
  }
}
