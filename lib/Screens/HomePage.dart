import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
//import 'package:flutter/foundation.dart';

import 'package:flutter_app/model/model.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

Future<List<States>> fetchCity() async {
  final response = await http.post('https://api.minebrat.com/api/v1/states');
  return parsePath(response.body);
}

List<States> parsePath(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  print(parsed);
  return parsed.map<States>((json) => States.fromJson(json)).toList();
}

//lass HomePage extends StatefulWidget {
//@override
//HomepageState createState() => HomepageState();
//}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: FutureBuilder<List<States>>(
        future: fetchCity(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          //print('$snapshot');
          return snapshot.hasData
              ? StatesList(state: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

enum Character { male, female }

class StatesList extends StatelessWidget {
  List<States> state;
  Character char = Character.male;
  List<City> city;

  StatesList({this.state, this.city, this.char});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your Name',
          ),
        ),
      ),
      Column(children: [
        ListTile(
          title: Text('Male'),
          leading: Radio(
            value: Character.male,
            groupValue: char,
            onChanged: (Character value) {
              //setState(() {
              char = value;
              //});
            },
          ),
        ),
        ListTile(
          title: Text('FeMale'),
          leading: Radio(
            value: Character.female,
            groupValue: char,
            onChanged: (Character value) {
              //setState(() {
              char = value;
              //});
            },
          ),
        ),
        TypeAheadField<States>(
          onSuggestionSelected: (state) =>
              print('selected: ${state.stateName}'),
          //suggestionsCallback: (s) => States.where((c) => c.name.toLowerCase().contains(s.toLowerCase())),
          itemBuilder: (ctx, state) => Text(
            state.stateName,
            textScaleFactor: 2,
          ),
        )
      ])
    ]));
  }
}
