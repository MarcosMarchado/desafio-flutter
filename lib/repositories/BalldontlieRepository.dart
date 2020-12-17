import 'dart:convert';
import 'package:flutter_desafio/model/PlayerBDModel.dart';
import 'package:flutter_desafio/model/PlayerModel.dart';
import 'package:flutter_desafio/model/TeamModel.dart';
import 'package:flutter_desafio/providers/dbProvider.dart';
import 'package:flutter_desafio/view-model/TeamWithPlayersViewModel.dart';
import 'package:http/http.dart' as http;

class BalldontlieRepository {
  Future<List<PlayerModel>> getPlayers(int page) async {
    var response = await http.get(
        "https://www.balldontlie.io/api/v1/players?per_page=100&page=$page");

    List<PlayerModel> players;

    Map responseMap = json.decode(response.body);

    players = (responseMap["data"] as List)
        .map((item) => PlayerModel.fromJson(item))
        .toList();

    players.forEach((player) async {
      await DBProvider.db.createPlayer({
        "firstName": player.firstName,
        "lastName": player.lastName,
        "team_id": player.team.id
      });
    });
  }

  handlerInsertDataBase() async {
    for (var i = 1; i <= 30; i++) {
      await getPlayers(i);
    }
  }

  Future<List<TeamWithPlayersViewModel>> getTeams(int page) async {
    var response = await http
        .get("https://www.balldontlie.io/api/v1/teams?per_page=2&page=$page");

    List<TeamModel> teams;

    Map responseMap = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      teams = (responseMap["data"] as List)
          .map((item) => TeamModel.fromJson(item))
          .toList();
    } else {
      teams = null;
    }

    List<TeamWithPlayersViewModel> resultado = List<TeamWithPlayersViewModel>();

    int count = teams.length;

    for (int i = 0; i < count; i++) {
      var count = await DBProvider.db.getCountPlayerPerTeam(teams[i].id);
      var fullName = teams[i].fullName;
      var id = teams[i].id;
      List<PlayerBDModel> players =
          await DBProvider.db.getPlayerPerTeam(teams[i].id);

      resultado.add(new TeamWithPlayersViewModel(
          countPlayers: count, fullName: fullName, id: id, players: players));
      print(resultado[0].fullName);
    }

    await handlerInsertDataBase();

    return resultado;
  }
}
