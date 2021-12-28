import 'package:champs2022rank1ng/src/models/champs_game_odd.dart';

class UpComingGame {
  String gameId;
  String time;
  String timeStatus;
  League league;
  Team home;
  Team away;
  GameOdd? gameOdd;
  String? score;


  UpComingGame(
      {this.gameOdd,
      this.score,
      required this.gameId,
      required this.time,
      required this.timeStatus,
      required this.league,
      required this.home,
      required this.away});

  factory UpComingGame.fromJson(Map<String, dynamic> json) {
    String? _score;
    if (json['score'] == null) {
      _score = null;
    } else {
      _score = json['score'];
    }
    League? _league =
        json['league'] != null ? League.fromJson(json['league']) : null;
    Team? _home = json['home'] != null ? Team.fromJson(json['home']) : null;
    Team? _away = json['away'] != null ? Team.fromJson(json['away']) : null;
    return UpComingGame(
        gameId: json['game_id'],
        time: json['time'],
        timeStatus: json['time_status'],
        league: _league!,
        home: _home!,
        away: _away!,
        score: _score);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['game_id'] = gameId;
    data['time'] = time;
    data['time_status'] = timeStatus;
    data['league'] = league.toJson();
    data['home'] = home.toJson();
    data['away'] = away.toJson();
    data['game_odd'] = gameOdd;
    data['score'] = score;
    return data;
  }
}

class League {
  String name;
  String cc;
  String id;

  League({required this.name, required this.cc, required this.id});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      name: json['name'],
      cc: json['cc'] ?? '',
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cc'] = cc;
    data['id'] = id;
    return data;
  }
}

class Team {
  String name;
  String id;
  String imageId;
  String cc;

  Team(
      {required this.name,
      required this.id,
      required this.imageId,
      required this.cc});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'],
      id: json['id'],
      imageId: json['image_id'],
      cc: json['cc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['image_id'] = imageId;
    data['cc'] = cc;
    return data;
  }
}
