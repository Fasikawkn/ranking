import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper extends ChangeNotifier {
  sql.Database? db;
  DBHelper() {
    init();
  }

  init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(path.join(dbPath, 'favorite_teams.db'),
        onCreate: (db, version) {
      final stmt = '''CREATE TABLE IF NOT EXISTS Favorite_teams (
            flag TEXT PRIMARY KEY,
            name TEXT,
            odd DOUBLE
        )'''
          .trim()
          .replaceAll(RegExp(r'[\s]{2,}'), ' ');
      return db.execute(stmt);
    }, version: 1);
    notifyListeners();
  }

  Future insertTeam(Map<String, dynamic> teamData) async {
    await db!.insert('Favorite_teams', teamData,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future deleteTeam(String flag) async {
    await db!.delete('Favorite_teams', where: 'flag = ?', whereArgs: [flag]);
  }

  Future<List<Map<String, dynamic>>> getFavoriteTeams() async {
    String query = "SELECT * FROM Favorite_teams ORDER BY odd ASC";
    return await db!.rawQuery(
      query,
    );
  }

  Future<bool> isFavorite(String teamId) async {
    print("The team IS is team${teamId}");
    String query = "SELECT 1 FROM Favorite_teams WHERE flag=$teamId";
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);
    return maps.isNotEmpty;
  }
}
