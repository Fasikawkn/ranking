import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/widgets/common/countries_list.dart';
import 'package:champs2022rank1ng/src/widgets/common/my_custom_date_picker.dart';
import 'package:champs2022rank1ng/src/widgets/z_champs_widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/champs/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {});
  }

  DateTime _selectedDate = DateTime.now();

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
        bottom: PreferredSize(
          preferredSize: size * 0.1,
          child: Container(
            color: greySecond,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    // color: greyFirst,
                    child: TextButton(
                      child: const Text(
                        "Countries >",
                        style: kAppbarTextStyle,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CountriesList(
                              onTap: (country){
                                debugPrint("The selected Country is $country");
                              },
                            ));
                      },
                    ),
                  )),
                  const VerticalDivider(
                    color: whiteColor,
                  ),
                  Expanded(
                      child: Container(
                    // color: greyFirst,
                    child: TextButton(
                      child: const Text(
                        "Date >",
                        style: kAppbarTextStyle,
                      ),
                      onPressed: () async {
                        debugPrint('Showing date');
                        await showDateMyCustomePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse("2022-06-27"),
                        ).then(
                          (value) => {
                            debugPrint(_selectedDate.toIso8601String()),
                            if (value != null)
                              {
                                setState(() {
                                  _selectedDate = value;
                                })
                              }
                          },
                        );
                      },
                    ),
                  )),
                ],
              ),
            ),
          ),
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
      bottomNavigationBar: CustomBottomAppBar(
        onSelect: (index) {
          debugPrint("Selected index $index");
        },
      ),
    );
  }
}
