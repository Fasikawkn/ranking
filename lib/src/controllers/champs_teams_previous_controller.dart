import 'dart:io';

import 'package:champs2022rank1ng/src/models/champs_game_odd.dart';
import 'package:champs2022rank1ng/src/models/chmaps_custome_models.dart';
import 'package:champs2022rank1ng/src/models/z_champs_models.dart';
import 'package:champs2022rank1ng/src/services/z_champs_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamPreviosGameController extends ChangeNotifier {
  final UpcomingMatchRepository repository;
  TeamPreviosGameController({required this.repository});
  UpcomingMatchReponse _matchReponse =
      UpcomingMatchReponse(data: null, modelStatus: UpcomingMatchStatus.idle);
  UpcomingMatchReponse _oddsResponse =
      UpcomingMatchReponse(data: null, modelStatus: UpcomingMatchStatus.idle);

  UpcomingMatchReponse get matchReponse => _matchReponse;

  set matchReponse(UpcomingMatchReponse response) {
    _matchReponse = response;
    notifyListeners();
  }

  UpcomingMatchReponse get oddsResponse => _oddsResponse;

  set oddsResponse(UpcomingMatchReponse response) {
    _oddsResponse = response;
    notifyListeners();
  }

  Future getTeamPreviousGames(String teamId) async {
    try {
      matchReponse = UpcomingMatchReponse(
          data: null, modelStatus: UpcomingMatchStatus.loading);
      final _response = await repository.getPreviousTeamGames(teamId);
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
      print("The issue is ${e.toString()}");
      matchReponse = UpcomingMatchReponse(
          data: null,
          modelStatus: UpcomingMatchStatus.error,
          error: ConnectionError(e.toString()));
    }
  }

  Future getOdds(List<UpComingGame> games, Team team, UpComingGame game) async {
    try {
      oddsResponse = UpcomingMatchReponse(
          data: null, modelStatus: UpcomingMatchStatus.loading);
      List<double> _odds = [];
      for (int i = 0; i < games.length; i++) {
        final response = await repository.getGameOdd(games[i].gameId);
        if (response is GameOdd) {
          if (games[i].away.name == team.name) {
            _odds.add(double.parse(response.awayOd));
          } else {
            _odds.add(double.parse(response.homeOd));
          }
        } else {
          _odds.add(0);
        }
      }
      final _finalResponse = await repository.getGameOdd(game.gameId);
      if (_finalResponse is GameOdd) {
        if (game.away.name == team.name) {
          _odds.add(double.parse(_finalResponse.awayOd));
        } else {
          _odds.add(double.parse(_finalResponse.homeOd));
        }
      } else {
        _odds.add(0);
      }
      
      oddsResponse = UpcomingMatchReponse(
          data: _odds, modelStatus: UpcomingMatchStatus.idle);
    } on SocketException catch (e) {
      oddsResponse = UpcomingMatchReponse(
          data: null,
          modelStatus: UpcomingMatchStatus.error,
          error: ConnectionError('Connection error'));
    } catch (e) {
      print("The odd error is ${e.toString()}");
      oddsResponse = UpcomingMatchReponse(
          data: null,
          modelStatus: UpcomingMatchStatus.error,
          error: ConnectionError('Something went wrong'));
    }
  }
}
