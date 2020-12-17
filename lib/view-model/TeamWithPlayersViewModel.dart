import 'package:flutter_desafio/model/PlayerBDModel.dart';

class TeamWithPlayersViewModel {
  int id;
  String fullName;
  int countPlayers;
  List<PlayerBDModel> players;

  TeamWithPlayersViewModel(
      {this.countPlayers, this.fullName, this.id, this.players});
}
