import 'dart:io';
import 'package:flutter_desafio/model/PlayerBDModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'players.db');
    // await deleteDatabase(path);
    return await openDatabase(path, version: 5, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE Player('
        'id INTEGER PRIMARY KEY,'
        'firstName TEXT,'
        'lastName TEXT UNIQUE,'
        'team_id INTEGER,'
        'api_id INTEGER UNIQUE'
        ')',
      );
    });
  }

  Future createPlayer(Map<String, dynamic> row) async {
    final db = await database;

    var res = await db.insert('Player', row);

    return res;
  }

  getAllPlayers() async {
    final db = await database;
    final res = await db
        .rawQuery("SELECT DISTINCT lastName, FirstName, team_id FROM PLAYER");
    print(res.length);
    return res;
  }

  Future<List<PlayerBDModel>> getPlayerPerTeam(int id) async {
    final db = await database;

    final res = await db.rawQuery(
        "SELECT DISTINCT lastName, FirstName, team_id, api_id FROM PLAYER p WHERE p.team_id = $id");

    int count = res.length;

    List<PlayerBDModel> playersPerTeam = List<PlayerBDModel>();

    for (int i = 0; i < count; i++) {
      playersPerTeam.add(PlayerBDModel.fromMapObject(res[i]));
    }
    return playersPerTeam;
  }

  getCountPlayerPerTeam(int id) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT DISTINCT lastName, FirstName, team_id FROM PLAYER p WHERE p.team_id = $id");

    return res.length;
  }

  deleteAllPlayers() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Player');
    return res;
  }
}
