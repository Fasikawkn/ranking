import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/widgets/z_champs_widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/champs/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyFourth,
        centerTitle: true,
        title: const Text(
          'Matches',
          style: kAppbarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: teams
              .map(
                (team) => ChampsTeamLabel(
                    teamOneName: team['teamOneName']!,
                    teamOneOdd: team['teamOneOdd']!,
                    teamTwoName: team['teamTwoName']!,
                    teamTwoOdd: team['teamTwoOdd']!,
                    teamsPlayDate: team['teamsPlayDate']!,
                    teamsPlayTime: team['teamsPlayTime']!),
              )
              .toList(),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: greyFourth,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: greyFourth),
              child: TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.home,
                ),
              ),
            ),
          ),
          const VerticalDivider(
            color: greyColor,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: greyFourth),
              child: TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.home,
                ),
              ),
            ),
          ),
          const VerticalDivider(
            color: greyColor,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: greyFourth),
              child: TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.home,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
