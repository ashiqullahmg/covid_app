import 'dart:convert';

import 'package:covid_app/Models/countries_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'countries_states.dart';

class CountriesList extends StatefulWidget {
  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  List<CountriesListModel> countriesList = [];

  Future<CountriesListModel> getCountriesList() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        for (Map i in data) {
          countriesList.add(CountriesListModel.fromJson(i));
        }
      });
      return CountriesListModel.fromJson(data);
    } else {
      return CountriesListModel.fromJson(data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCountriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries List'),
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: countriesList.length,
                  itemBuilder: (context, index) {
                    var data = countriesList[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountriesStates(
                                    name: countriesList[index]
                                        .country
                                        .toString())));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(countriesList[index]
                                        .countryInfo!
                                        .flag
                                        .toString())),
                                SizedBox(
                                  width: 10,
                                ),
                                // Text(data.country.toString()),
                                Text(countriesList[index].country.toString()),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
