import 'package:flutter/material.dart';
import 'package:flutter_desafio/repositories/BalldontlieRepository.dart';
import 'package:flutter_desafio/view-model/TeamWithPlayersViewModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BalldontlieRepository _repository;

  @override
  void initState() {
    _repository = BalldontlieRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: _repository.getTeams(1),
              builder: (context, snapshot) {
                List<TeamWithPlayersViewModel> teams = snapshot.data;
                return ListView.builder(
                  itemCount: snapshot.data.le,
                  itemBuilder: (context, index) {
                    TeamWithPlayersViewModel team = teams[index];
                    // List<PlayerBDModel> players = team.players;
                    return ListTile(
                      title: Text("${team.fullName}"),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _repository.getTeams(1);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
