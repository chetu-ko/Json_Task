class States {
  final String stateId;
  final String stateName;
  final List<City> city;

  States({this.stateId, this.stateName, this.city});

  factory States.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['city'] as List;
    final sublist = list.cast<Map<String, dynamic>>();
    List<City> city2;

    List<City> parseCity(responseBody1) {
      return responseBody1.map<City>((json) => City.fromJson(json)).toList();
    }

    city2 = parseCity(sublist);

    return States(
        stateId: parsedJson['stateId'],
        stateName: parsedJson['stateName'],
        city: city2);
  }
}

class City {
  final String cityId;
  final String cityName;

  City({this.cityId, this.cityName});

  factory City.fromJson(Map<String, dynamic> parsedJson) {
    return City(
      cityId: parsedJson['cityId'],
      cityName: parsedJson['cityName'],
    );
  }
}

/*body: FutureBuilder<List<Paths>>(
     future: fetchPhotos(),
       builder: (context, snapshot) {
      if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? PathsList(paths: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}*/
