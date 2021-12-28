import 'package:champs2022rank1ng/src/models/champs_game_odd.dart';
import 'package:champs2022rank1ng/src/models/z_champs_models.dart';
import 'package:champs2022rank1ng/src/services/data_providers/chamsp_upcoming_match_data.dart';

class UpcomingMatchRepository {
  final UpcomingGameDataProvider dataProvider;
  UpcomingMatchRepository({required this.dataProvider});

  Future<List<UpComingGame>> getUpcomingGame(String date) async {
    return await dataProvider.getUpcomingGame(date);
  }

  Future<GameOdd> getGameOdd(String gameId) async {
    return await dataProvider.getGameOdd(gameId);
  }

  Future<List<UpComingGame>> getPreviousTeamGames(String teamId) async {
    return await dataProvider.getPreviousTeamGames(teamId);
  }
}
