import 'package:champs2022rank1ng/src/models/z_champs_models.dart';

class CustomFunctions {
  static String getDate(String timeStamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);
    return "${date.day}.${date.month}.${date.year.toString().substring(2)}";
  }

  static String getTime(String timeStamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);
    return "${date.hour}:${date.minute}";
  }

  // static List<List<Team>> getTopTeams(List<UpComingGame> matches) {
  //   List<Team> _topTeams = [];
  //   for (int i = 0; i < matches.length; i++) {
  //     _topTeams.add(matches[i].home);
  //     _topTeams.add(matches[i].away);
  //   }
  //   return _topTeams.sort((a,b) => a.)
  // }
}
