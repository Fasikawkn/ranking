import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/widgets/z_champs_widgets.dart';
import 'package:flutter/material.dart';

class ChampsTopTeams extends StatelessWidget {
  const ChampsTopTeams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyFourth,
        centerTitle: true,
        title: const Text(
          "Top Teams",
          style: kAppbarTextStyle,
        ),
      ),
      body: ListView(
        children: [1, 2, 3, 4, 5, 6, 7, 8]
            .map(
              (e) => Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: greyColor.withOpacity(0.5),
                ))),
                child: TeamFavNameOddImage(
                  image: "assets/images/chelsea-badge-download.png",
                  name: "Chelsea",
                  odd: "1.62",
                  onPressed: () {},
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
