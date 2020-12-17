import 'package:flutter_desafio/model/TeamModel.dart';

class PlayerModel {
  int id;
  String firstName;
  String lastName;
  TeamModel team;

  PlayerModel({this.id, this.firstName, this.lastName, this.team});

  PlayerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    team = json['team'] != null ? new TeamModel.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.team != null) {
      data['team'] = this.team.toJson();
    }
    return data;
  }
}
