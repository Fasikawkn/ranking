import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/widgets/z_champs_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChampsTeamDetail extends StatelessWidget {
  static const routeName = "/chaps/teamDetail";
  const ChampsTeamDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          'Team',
          style: kAppbarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TeamFavNameOddImage(
                image: "assets/images/chelsea-badge-download.png",
                name: "Chelsea",
                odd: "1.62",
                onPressed: () {},
              ),
              Container(
                  height: 170.0,
                  width: size.width,
                  color: greyFourth,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: SfSparkLineChart(
                    //Enable the trackball
                    // trackball: const SparkChartTrackball(
                    //     activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: const SparkChartMarker(
                        color: whiteColor,
                        borderColor: whiteColor,
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.last,
                    axisLineColor: greyFourth,
                    color: primaryColor,
                    labelStyle: const TextStyle(
                        color: whiteColor,
                        fontFamily: "Open Sans",
                        fontSize: 16.0),
                    data: const <double>[0.5, 0.3, 0.65, 1, 0.6, 1.55],
                  )),
              ExpansionTile(
                  title: const Text(
                    "Past odds",
                    style: TextStyle(
                        color: greyFourth,
                        fontFamily: "Open Sans",
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700),
                  ),
                  children: _pastGames())
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _pastGames() {
    return [1, 2, 3, 4]
        .map((e) => const ChampsTeamLabel(
              teamOneName: "Chlelsea",
              teamOneOdd: "1.25",
              teamTwoName: "Arsenal",
              teamTwoOdd: "1.25",
              teamsPlayDate: '31.08.21',
              teamsPlayTime: '21:00',
            ))
        .toList();
  }
}
