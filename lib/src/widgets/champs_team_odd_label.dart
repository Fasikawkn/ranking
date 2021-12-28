import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/z_champs_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChampsTeamOddLabel extends StatefulWidget {
  const ChampsTeamOddLabel({
    Key? key,
    required this.name,
    required this.odd,
  }) : super(key: key);

  final String name;
  final Widget odd;

  @override
  State<ChampsTeamOddLabel> createState() => _ChampsTeamOddLabelState();
}

class _ChampsTeamOddLabelState extends State<ChampsTeamOddLabel> {
  late UpcomingMatchModel matchModel;
  @override
  Widget build(BuildContext context) {
    matchModel = Provider.of<UpcomingMatchModel>(context, listen: false);
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
                widget.name,
                style: kAppbarTextStyle.copyWith(color: Colors.black),
              ),
              SizedBox(
                width: size.width * 0.06,
              ),
             widget.odd,
            ],
          ),
        )
      ],
    );
  }
}
