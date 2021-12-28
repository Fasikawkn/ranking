import 'package:champs2022rank1ng/src/models/champs_pregame_model.dart';

class TopTeam {
  final String name;
  final String flag;
  final double odd;
  final UpComingGame? game;
  final Team? team;

  TopTeam({
    this.game,
    this.team,
    required this.name,
    required this.flag,
    required this.odd,
  });

  factory TopTeam.fromJson(Map<String, dynamic> json) {
    return TopTeam(
      name: json['name'],
      flag: json['flag'],
      odd: double.parse(json['odd'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'flag': flag,
      'odd': odd,
    };
  }
}
