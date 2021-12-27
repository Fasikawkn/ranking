import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:champs2022rank1ng/src/widgets/z_champs_widgets.dart';
import 'package:flutter/cupertino.dart';
// import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:flutter/material.dart';

class ChampsTeamLabel extends StatelessWidget {
  const ChampsTeamLabel({
    required this.teamOneName,
    required this.teamTwoName,
    required this.teamOneOdd,
    required this.teamTwoOdd,
    required this.teamsPlayTime,
    required this.teamsPlayDate,
    Key? key,
  }) : super(key: key);

  final String teamOneName;
  final String teamTwoName;
  final String teamOneOdd;
  final String teamTwoOdd;
  final String teamsPlayTime;
  final String teamsPlayDate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChampsPlayTeamsDetail()));
      },
      child: Container(
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
                  date: teamsPlayDate,
                  time: teamsPlayTime,
                ),
                Row(
                  children: [
                    ChampsTeamOddLabel(
                      name: teamOneName,
                      odd: teamOneOdd,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    ChampsTeamOddLabel(
                      name: teamTwoName,
                      odd: teamTwoOdd,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
