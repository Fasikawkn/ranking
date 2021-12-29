import 'dart:math';


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

double generateRandomDouble() {
  double _randomDouble = ( Random().nextDouble() * 6)  + 1;
  return _randomDouble.toPrecision(2);
}
extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}