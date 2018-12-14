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
    var map = [{"id":48,"title":"Helgelandskysten","lng":12.63376,"lat":66.02219},
    {"id":46,"title":"Tysfjord","lng":16.50279,"lat":68.03515},
    {"id":44,"title":"Sledehunds-ekspedisjon","lng":7.53744,"lat":60.08929},
    {"id":43,"title":"Amundsens sydpolferd","lng":11.38411,"lat":62.57481},
    {"id":39,"title":"Vikingtokt","lng":6.96781,"lat":60.96335},
    {"id":6,"title":"Tungtvann- sabotasjen","lng":8.49139,"lat":59.87111}
    ];
    
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (map != null) {
          _results = map.where((p)=>p['title'].toString().contains(query)).toList();
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
      return  ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_results[index]['title']),
              subtitle: Text(_results[index]['lat'].toString() + "  "+ _results[index]['lng'].toString()),
              onTap: (){
                print(_results[index]['lat']);
                print(_results[index]['lng']);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>MapsDemo(
                    lat:_results[index]['lat'],
                    lng:_results[index]['lng'],

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
// ListView.builder(
//           padding: EdgeInsets.symmetric(vertical: 8.0),
//           itemCount: _results.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text(_results[index]['title']),
//               subtitle: Text(_results[index]['lat'].toString() + "  "+ _results[index]['lng'].toString()),
//               onTap: (){
//                 print(_results[index]['lat']);
//                 print(_results[index]['lng']);

//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context)=>MapsDemo(
//                     lat:_results[index]['lat'],
//                     lng:_results[index]['lng'],

//                   )
//                 ));
//               },
//             );
//           })