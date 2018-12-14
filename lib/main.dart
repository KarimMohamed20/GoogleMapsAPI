import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maps_place/MapsPage.dart';

void main() => runApp(MaterialApp(
  home: SearchList(),
));
class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchList> {
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  var _results;

  Timer debounceTimer;

  _SearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });
    var map = [{
    "city": "Amsterdam",
    'address':"Flangomn",
    "lat":26.820553,
    'lng':30.802498
  },
  {
    "city": "droman",
    'address':"valro",
    "lat":26.820553,
    'lng':30.802498
  },
    {"city": "Loral",
    'address':"markov",
    "lat":26.820553,
    'lng':30.802498
  }
  ];
    
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (map != null) {
          _results = map.where((p)=>p['address'].toString().contains(query)).toList();
        } else {
          _error = 'Error searching';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextField(
            autofocus: true,
            controller: _searchQuery,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(end: 16.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return CenterTitle('Searching');
    } else if (_error != null) {
      return CenterTitle(_error);
    } else if (_searchQuery.text.isEmpty) {
      return CenterTitle('Begin Search by typing on search bar');
    } else {
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_results[index]['city']),
              subtitle: Text(_results[index]['address']),
              onTap: (){
                print(_results[index]['lat']);
                print(_results[index]['lng']);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>MapsDemo(
                    lat:_results[index]['lat'],
                    lng:_results[index]['lng'],
                    address:_results[index]['address'],
                    city:_results[index]['city']
                  )
                ));
              },
            );
          });
    }
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ));
  }
}
