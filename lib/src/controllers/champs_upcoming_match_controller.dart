import 'dart:io';

import 'package:champs2022rank1ng/src/models/champs_game_odd.dart';
import 'package:champs2022rank1ng/src/models/champs_pregame_model.dart';
import 'package:champs2022rank1ng/src/models/champs_top_teams.dart';
import 'package:champs2022rank1ng/src/models/chmaps_custome_models.dart';
import 'package:champs2022rank1ng/src/services/z_champs_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingMatchModel extends ChangeNotifier {
  final UpcomingMatchRepository repository;
  UpcomingMatchModel({required this.repository});

  UpcomingMatchReponse _matchReponse = UpcomingMatchReponse(
      data: null, modelStatus: UpcomingMatchStatus.loading);

  UpcomingMatchReponse get matchReponse => _matchReponse;

  set matchReponse(UpcomingMatchReponse response) {
    _matchReponse = response;
    notifyListeners();
  }

  UpcomingMatchReponse _topTeamsReponse = UpcomingMatchReponse(
      data: null, modelStatus: UpcomingMatchStatus.loading);

  UpcomingMatchReponse get topTeamsReponse => _topTeamsReponse;

  set topTeamsReponse(UpcomingMatchReponse response) {
    _topTeamsReponse = response;
    notifyListeners();
  }

  Future getUpcomingMatches(String date) async {
    try {
      matchReponse = UpcomingMatchReponse(
          data: null, modelStatus: UpcomingMatchStatus.loading);
      final _response = await repository.getUpcomingGame(date);

      if (_response is List<UpComingGame>) {
        matchReponse = UpcomingMatchReponse(
            data: _response, modelStatus: UpcomingMatchStatus.idle);
      } else {
        matchReponse = UpcomingMatchReponse(
            data: null,
            modelStatus: UpcomingMatchStatus.error,
            error: FormatError('Something went wrong'));
      }
    } on SocketException catch (e) {
      matchReponse = UpcomingMatchReponse(
          data: null,
          modelStatus: UpcomingMatchStatus.error,
          error: ConnectionError('Connection error'));
    } catch (e) {
      print("Date fetch error is ");
      print(e.toString());
      matchReponse = UpcomingMatchReponse(
          data: null,
          modelStatus: UpcomingMatchStatus.error,
          error: FormatError('Something went wrong'));
    }
  }

  Future<GameOdd> getOdd(String gameId) async {
    return await repository.getGameOdd(gameId);
  }

  Future getTopTeams(List<UpComingGame> games) async {
    try {
      topTeamsReponse = UpcomingMatchReponse(
          data: null, modelStatus: UpcomingMatchStatus.loading);
      List<TopTeam> _topTeams = [];
      for (int i = 0; i < 30; i++) {
        UpComingGame _upcomingGame = games[i];
        final _response = await getOdd(_upcomingGame.gameId);
        if (_response is GameOdd) {
          TopTeam _topTeam1 = TopTeam(
            game: _upcomingGame,
            name: _upcomingGame.home.name,
            flag: _upcomingGame.home.id,
            team: _upcomingGame.home,
            odd: double.parse(
              _response.homeOd,
            ),
          );
          TopTeam _topTeam2 = TopTeam(
              game: _upcomingGame,
              name: _upcomingGame.away.name,
              flag: _upcomingGame.away.id,
              team: _upcomingGame.away,
              odd: double.parse(_response.drawOd));

          _topTeams.add(_topTeam1);
          _topTeams.add(_topTeam2);
        }
      }
      _topTeams.sort((a, b) => a.odd.compareTo(b.odd));
      topTeamsReponse = UpcomingMatchReponse(
          data: _topTeams, modelStatus: UpcomingMatchStatus.idle);
    } on SocketException catch (err) {
      topTeamsReponse = UpcomingMatchReponse(
          data: null,
          modelStatus: UpcomingMatchStatus.error,
          error: ConnectionError('Connection error'));
    } catch (e) {
      print("The Top error is ${e.toString()}");
      topTeamsReponse = matchReponse = UpcomingMatchReponse(
          data: null,
          modelStatus: UpcomingMatchStatus.error,
          error: FormatError('Something went wrong'));
    }
  }

  Future filterMatchesByCountry(
      String countryCode, BuildContext context) async {
    print('cc is $countryCode');
    try {
      matchReponse = UpcomingMatchReponse(
          data: null, modelStatus: UpcomingMatchStatus.loading);
      await getUpcomingMatches('today');
      UpcomingMatchReponse _response =
          Provider.of<UpcomingMatchModel>(context, listen: false).matchReponse;
      print("The countrie filtered is ${_response.data}");
      List<UpComingGame> _countryGames = [];
      if (_response.data is List) {
        List<UpComingGame> games = _response.data;
        for (int i = 0; i < games.length; i++) {
          UpComingGame _game = games[i];
          print(_game.league.cc);
          if (_game.league.cc == countryCode) {
            _countryGames.add(_game);
          }
        }
      }
      print("the filtered country is $_countryGames");
      matchReponse = UpcomingMatchReponse(
          data: _countryGames, modelStatus: UpcomingMatchStatus.idle);
    } catch (e) {
      topTeamsReponse = matchReponse = UpcomingMatchReponse(
        data: null,
        modelStatus: UpcomingMatchStatus.error,
        error: FormatError('Something went wrong'),
      );
    }
  }
}
