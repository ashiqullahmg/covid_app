import 'package:covid_app/Models/countries_states_model.dart';

import 'package:covid_app/components/reusableCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'all_countries.dart';

class CountriesStates extends StatefulWidget {
  final String? name;
  final String? flag;
  CountriesStates({this.name, this.flag});

  @override
  _CountriesStatesState createState() => _CountriesStatesState();
}

class _CountriesStatesState extends State<CountriesStates> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStates();
  }

  Future<CountriesStatesModel> _getStates() async {
    var response = await http.get(Uri.parse(
        'https://disease.sh/v3/covid-19/countries/' + widget.name.toString()));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return CountriesStatesModel.fromJson(data);
    } else {
      return CountriesStatesModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: NetworkImage(widget.flag.toString())),
          SizedBox(
            height: 10.0,
          ),
          Text(widget.name.toString() + ' Cases'),
          SizedBox(
            height: 30,
          ),
          FutureBuilder<CountriesStatesModel>(
            future: _getStates(),
            builder: (context, snapshot) {
              print(snapshot.data);
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
                          data: snapshot.data?.active.toString()),
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
              child: Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
