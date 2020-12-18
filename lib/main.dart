import 'package:flutter/material.dart';
import 'package:flutter_desafio/repositories/BalldontlieRepository.dart';
import 'package:flutter_desafio/view-model/TeamWithPlayersViewModel.dart';
import 'package:flutter_desafio/widgets/CustomList.dart';
import 'package:flutter_section_list_view/flutter_section_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            backgroundColor: Color(0XFFFCFCFC),
            expandedHeight: 140.0,
            floating: false,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text(
                "NBA Teams",
                style: TextStyle(
                  fontFamily: 'MyWebFont',
                  fontWeight: FontWeight.w900,
                  color: Color(0XFF2D2E2F),
                  fontSize: 28,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: _buildList(_repository.getTeams(1)),
          )
        ],
      ),
    );
  }
}

Widget _buildList(future) {
  return FutureBuilder(
    future: future,
    builder: (context, snapshot) {
      List<TeamWithPlayersViewModel> teams = snapshot.data;
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return FlutterSectionListView(
        numberOfSection: () => teams.length,
        numberOfRowsInSection: (section) {
          return teams[section].players.length;
        },
        sectionWidget: (section) {
          return Container(
            height: 54,
            padding: EdgeInsets.only(left: 25),
            color: Color(0XFFFCFCFC),
            child: Row(
              children: [
                Text(
                  "${teams[section].fullName}",
                  style: TextStyle(
                    fontFamily: 'MyWebFont',
                    color: Color(0XFF2D2E2F),
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${teams[section].countPlayers}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0XFF565758),
                    fontSize: 18,
                  ),
                )
              ],
            ),
          );
        },
        rowWidget: (section, row) {
          var firstName = teams[section].players[row].firstName;
          var lastName = teams[section].players[row].lastName;
          var id = teams[section].players[row].api_id;
          print(teams[section].players[row].id);
          return Container(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  "G",
                  style: TextStyle(
                    fontFamily: 'MyWebFont',
                    color: Color(0XFF2D2E2F),
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Color(0XFFF4F5F5),
              ),
              title: Text(
                "$id",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0XFF909091),
                ),
              ),
              subtitle: Text(
                "$firstName $lastName",
                style: TextStyle(
                  color: Color(0XFF2D2E2F),
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
