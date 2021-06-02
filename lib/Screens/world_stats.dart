import 'dart:convert';

import 'package:covid_app/Models/world_states_model.dart';
import 'package:covid_app/Screens/all_countries.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_app/components/reusableCard.dart';

class WorldStates extends StatefulWidget {
  @override
  _WorldStatesState createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWorldRecords();
  }

  Future<WorldStatesModel> _getWorldRecords() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return WorldStatesModel.fromJson(data);
    } else {
      return WorldStatesModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('World States'),
          SizedBox(
            height: 30,
          ),
          FutureBuilder<WorldStatesModel>(
            future: _getWorldRecords(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  child: Column(
                    children: [
                      MyColumn(
                          title: 'Total Deaths',
                          data: snapshot.data?.deaths.toString()),
                      MyColumn(
                          title: 'Active Cases',
                          data: snapshot.data?.deaths.toString()),
                      MyColumn(
                          title: 'Recovered',
                          data: snapshot.data?.recovered.toString()),
                      MyColumn(
                          title: 'Today Cases',
                          data: snapshot.data?.todayCases.toString()),
                      MyColumn(
                          title: 'Today Deaths',
                          data: snapshot.data?.todayDeaths.toString()),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            child: MaterialButton(
              color: Colors.green,
              child: Text('Countries Tracker'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CountriesList()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
