class PlayerBDModel {
  int id;
  String firstName;
  String lastName;
  int team_id;
  int api_id;

  PlayerBDModel(
      {this.firstName, this.lastName, this.id, this.team_id, this.api_id});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['team_id'] = team_id;
    map['api_id'] = api_id;
    return map;
  }

  PlayerBDModel.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.team_id = map['team_id'];
    this.api_id = map['api_id'];
  }
}
