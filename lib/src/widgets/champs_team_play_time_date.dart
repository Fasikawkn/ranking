import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';

class ChampsTeamPlayTimeDate extends StatelessWidget {
  const ChampsTeamPlayTimeDate(
      {Key? key, required this.date, required this.time})
      : super(key: key);

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
      child: Row(
        children: [
          Text(date, style: kTimeDateTextStyle),
          SizedBox(
            width: size.width * 0.01,
          ),
          Text(
            time,
            style: kTimeDateTextStyle,
          ),
        ],
      ),
    );
  }
}