import 'dart:convert';

import 'package:champs2022rank1ng/src/models/champs_game_odd.dart';
import 'package:champs2022rank1ng/src/models/z_champs_models.dart';
import "package:http/http.dart" as http;

String _getMatchURL(String date) {
  print("date");
  if (date == 'today') {
    print("Todays");
    return 'https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=predata&sport=soccer&day=today';
  } else {
    DateTime _timeMatch = DateTime.parse(date);
    int _value = _timeMatch.compareTo(DateTime.now());
    String _dateString =
        '${_timeMatch.year}${_timeMatch.month}${_timeMatch.day}';
    if (_value == 0) {
      return 'https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=predata&sport=soccer&day=today';
    } else if (_value < 0) {
      return 'https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=enddatapage&sport=soccer&day=$_dateString';
    } else {
      return 'https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=predata&sport=soccer&day=$_dateString';
    }
  }
}

class UpcomingGameDataProvider {
  final http.Client httpClient;

  UpcomingGameDataProvider({required this.httpClient});
  Future<List<UpComingGame>> getUpcomingGame(String date) async {
    print(_getMatchURL(date));
    final _response = await httpClient.get(
      Uri.parse(_getMatchURL(date)),
    );
    if (_response.statusCode == 200) {
      final _responseData = jsonDecode(_response.body) as Map;
      print("the returned list is $_responseData");
      if (_responseData['games_pre'] != null) {
        final _upcomingMatch = _responseData['games_pre'] as List;
         return _upcomingMatch.map((match) {
        return UpComingGame.fromJson(match);
      }).toList();
      }else{
          final _upcomingMatch = _responseData['games_end'] as List;
         return _upcomingMatch.map((match) {
        return UpComingGame.fromJson(match);
      }).toList();
      }
     
     
    } else {
      throw Exception(_response.body);
    }
  }

  Future<GameOdd> getGameOdd(String gameId) async {
    final _response = await httpClient.get(
      Uri.parse(
          "https://spoyer.ru/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=odds&game_id=" +
              gameId),
    );
    if (_response.statusCode == 200) {
      final _jsonResponse = jsonDecode(_response.body) as Map<String, dynamic>;
      final _oddss = _jsonResponse['odds'];
      if (_oddss.isEmpty) {
        return GameOdd(homeOd: '0', drawOd: "0", awayOd: "0");
      }
      final _odds = _jsonResponse['odds'] as Map<String, dynamic>;
      final _bet365 = _odds['Bet365'];
      if (_bet365 == null) {
        
        return GameOdd(homeOd: '0', drawOd: "0", awayOd: "0");
      }
      final _prematch = _bet365['prematch'] as List;
      return GameOdd.fromJson(_prematch[0]);
    } else {
      throw Exception(_response.body);
    }
  }

  Future<List<UpComingGame>> getPreviousTeamGames(String teamId) async {
    final _response = await httpClient.get(Uri.parse(
        "https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=enddata&sport=soccer&team=$teamId"));
    if (_response.statusCode == 200) {
      final _jsonResponse = jsonDecode(_response.body) as Map<String, dynamic>;
      final _gameEnds = _jsonResponse['games_end'] as List;
      return _gameEnds
          .sublist(0, 6)
          .map((match) => UpComingGame.fromJson(match))
          .toList();
    } else {
      throw Exception(_response.body);
    }
  }
}
