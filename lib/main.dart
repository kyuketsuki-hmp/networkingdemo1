import 'dart:convert';

import 'package:flutter/material.dart';

//Notes to import like this
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _usdRate = "Click to load data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: Text("USD Rate : $_usdRate")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getData();
          },
          tooltip: "Load Data",
          child: Icon(Icons.add),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
  //Future kind of type

  getData() async {
    var url = "http://forex.cbm.gov.mm/api/latest";

    //var response = await http.get(url); OR

    var responseFuture = http.get(url);
    responseFuture.then((response) {
      if (response.statusCode == 200) {
        var body = response.body; //return string it is json flatten
        Map<String, dynamic> json = jsonDecode(body);
        Map<String, dynamic> rate = json["rates"];
        setState(() {
          _usdRate = rate["USD"] as String;
        });
      }
    });
  }
}
