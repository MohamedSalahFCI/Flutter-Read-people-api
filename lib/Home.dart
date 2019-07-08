import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://swapi.co/api/people";
  List data;
  Future<String> getMyData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accepts": "application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      //hna 3shan fe data 2apl result f 3mlt kda fel list ya m3lam
      data = resBody["results"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Read people json "),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
        future: getMyData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("you r here");
            return ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  elevation: 4.0,
                  color: Colors.grey,
                  child: Container(
                    height: 90,
                    child: Column(
                      children: <Widget>[
                        new Text(
                          data[index]["name"],
                          textAlign: TextAlign.start,
                        ),
                        //new Text("${data.length}"),
                        new Row(
                          children: <Widget>[
                            Expanded(
                              child: new ListTile(
                                title: new Text("Height"),
                                subtitle: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: new Text(data[index]["height"])),
                              ),
                            ),
                            Expanded(
                              //hna 3amlhom bel center wel ba2y bel padding
                              child: new ListTile(
                                  title: Center(child: new Text("Hair Color")),
                                  subtitle: Center(
                                    child: new Text(data[index]["hair_color"]),
                                  )),
                            ),
                            Expanded(
                              child: new ListTile(
                                title: new Text("Birth year"),
                                subtitle: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: new Text(data[index]["birth_year"])),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }
          return new Center(child: new CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getMyData();
  }
}

/*
appBar: AppBar(
        title: new Text("Read People Api"),
      ),
      body: Card(
        color: Colors.grey,
        child: Container(
          height: 90,
          child: Column(
            children: <Widget>[
              new Text("Momo",textAlign: TextAlign.start,),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: new ListTile(
                      title: new Text("Height"),
                      subtitle: new Text("5"),
                    ),
                  ),
                  Expanded(
                    child: new ListTile(
                      title: new Text("Hair Color"),
                      subtitle: new Text("5"),
                    ),
                  ),
                  Expanded(
                    child: new ListTile(
                      title: new Text("Birth year"),
                      subtitle: new Text("5"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      
 */
