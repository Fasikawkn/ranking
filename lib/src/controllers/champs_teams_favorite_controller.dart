import 'package:champs2022rank1ng/src/db/db_helper.dart';
import 'package:champs2022rank1ng/src/models/champs_top_teams.dart';
import 'package:champs2022rank1ng/src/models/chmaps_custome_models.dart';
import 'package:flutter/material.dart';

class FavoriteContorller extends ChangeNotifier {
  final DBHelper? dbHelper;
  List<TopTeam> _topTeams = [];

  FavoriteContorller(this.dbHelper, this._topTeams) {
    if (dbHelper != null) {
      getAllFavoriteteams();
    }
  }



  List<TopTeam> get items => [..._topTeams];

  UpcomingMatchReponse _favoriteResponse = UpcomingMatchReponse(
      data: null, modelStatus: UpcomingMatchStatus.loading);

  UpcomingMatchReponse get favoriteResponse => _favoriteResponse;

  set favoriteResponse(UpcomingMatchReponse response) {
    _favoriteResponse = response;
    notifyListeners();
  }

  // get All Categories
  Future getAllFavoriteteams() async {
    print("Getting all the favorite teams");
    if (dbHelper!.db != null) {
      print("inside fethcing favorites");
      try {
        UpcomingMatchReponse(
            data: null, modelStatus: UpcomingMatchStatus.loading);
        final _response = await dbHelper!.getFavoriteTeams();

        if (_response is List) {
          print("get ing");
          print(_response);
          List<TopTeam> _teams =
              _response.map((team) => TopTeam.fromJson(team)).toList();
          _topTeams = _teams;
          favoriteResponse = UpcomingMatchReponse(
              data: _teams, modelStatus: UpcomingMatchStatus.idle);
        }
      } catch (e) {
        print("THe error is ${e.toString()}");
        favoriteResponse = UpcomingMatchReponse(
            data: null,
            modelStatus: UpcomingMatchStatus.error,
            error: FormatError('Something went wrong'));
      }
    }
  }

  Future insertTeam(TopTeam team) async {
    if (dbHelper!.db != null) {
      await dbHelper!.insertTeam(team.toJson());
      await getAllFavoriteteams();
    }
  }

  Future deleteTeam(String flag) async {
    if (dbHelper!.db != null) {
      await dbHelper!.deleteTeam(flag);
      await getAllFavoriteteams();
    }
  }

  Future<bool> isFavorite(String teamId) async {
    if (dbHelper!.db != null) {
      return await dbHelper!.isFavorite(teamId);
    } else {
      return false;
    }
  }
}
