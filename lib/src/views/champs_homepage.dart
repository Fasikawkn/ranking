import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/z_champs_controllers.dart';
import 'package:champs2022rank1ng/src/models/champs_pregame_model.dart';
import 'package:champs2022rank1ng/src/models/chmaps_custome_models.dart';
import 'package:champs2022rank1ng/src/views/z_champs_views.dart';
import 'package:champs2022rank1ng/src/widgets/common/countries_list.dart';
import 'package:champs2022rank1ng/src/widgets/common/my_custom_date_picker.dart';
import 'package:champs2022rank1ng/src/widgets/z_champs_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    double height = AppBar().preferredSize.height;
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
                        "Country   >",
                        style: kAppbarTextStyle,
                      ),
                      onPressed: () async {
                        final countryCode = await showDialog(
                          context: context,
                          builder: (context) => const CountriesList(),
                        );
                        debugPrint("The selected country code is $countryCode");
                         if(countryCode != null) {
                          final model =      Provider.of<UpcomingMatchModel>(context,
                                listen: false);
                          if(model.matchReponse.data is List){
                              await model.filterMatchesByCountry(countryCode, model.allReponse.data);
                          }
                            
                        }
                    
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
                        DateTime dateTime = DateTime.now();
                        final _response = await showDateMyCustomePicker(
                          context: context,
                          initialDate: dateTime,
                          firstDate:
                              dateTime.subtract(const Duration(days: 30)),
                          lastDate: dateTime.add(const Duration(days: 30)),
                        );
                        String _matchDate =
                            '${_response!.year}${_response.month}${_response.day}';
                        print("The selected date is $_matchDate");
                        await Provider.of<UpcomingMatchModel>(context,
                                listen: false)
                            .getUpcomingMatches(_response.toString());
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
        child: Consumer<UpcomingMatchModel>(
          builder: (context, state, child) {
            if (state.matchReponse.modelStatus == UpcomingMatchStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.matchReponse.modelStatus ==
                UpcomingMatchStatus.idle) {
              List<UpComingGame> _games = state.matchReponse.data;

              return _games.isEmpty? const Center(child: Text("No Matches!"),): Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _games
                    .map(
                      (game) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChampsPlayTeamsDetail(
                                    game: game,
                                  )));
                        },
                        child: ChampsTeamLabel(
                          game: game,
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return Center(
                child: Text(state.matchReponse.error!.message),
              );
            }
          },
        ),
      ),
    );
  }
}
