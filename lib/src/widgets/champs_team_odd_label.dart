import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';


class ChampsTeamOddLabel extends StatelessWidget {
  const ChampsTeamOddLabel({Key? key, required this.name, required this.odd})
      : super(key: key);

  final String name;
  final String odd;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          decoration: BoxDecoration(
              color: lightGreen, borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            children: [
              Text(
                name,
                style: kAppbarTextStyle.copyWith(color: Colors.black),
              ),
              SizedBox(
                width: size.width * 0.06,
              ),
              Text(
                odd,
                style: kAppbarTextStyle.copyWith(color: Colors.black),
              )
            ],
          ),
        )
      ],
    );
  }
}