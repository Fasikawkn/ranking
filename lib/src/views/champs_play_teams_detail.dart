import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:champs2022rank1ng/src/widgets/champs_team_odd_label.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ChampsPlayTeamsDetail extends StatelessWidget {
  static const routeName = "/champs/teamsdetail";
  const ChampsPlayTeamsDetail({Key? key}) : super(key: key);

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
                const Text("UEFA Champions League",
                    style: kLeagueNameLabelStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("04.01.22", style: kLeagueGameTimeLabelStyle),
                    SizedBox(width: 10.0),
                    Text('21:00', style: kLeagueGameTimeLabelStyle)
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("4 - 2",
                    style: TextStyle(
                      color: greyFourth,
                      fontWeight: FontWeight.w900,
                      fontSize: 40.0,
                      fontFamily: "Open Sans",
                    ))
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  DetailTeamNameOddLabel(
                    name: "Paris Saint-Germain",
                    odd: 1.25,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DetailTeamNameOddLabel(
                    name: "Manchester United",
                    odd: 2.15,
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
            children: const [
              ChampsTeamOddLabel(name: 'Draw', odd: "1.55"),
            ],
          )
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
  final double odd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ChampsTeamDetail(),
          ),
          
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
            color: lightGreen, borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                  color: greyFourth,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0),
            ),
            Text(
              "$odd",
              style: kAppbarTextStyle.copyWith(color: greyFourth),
            )
          ],
        ),
      ),
    );
  }
}
