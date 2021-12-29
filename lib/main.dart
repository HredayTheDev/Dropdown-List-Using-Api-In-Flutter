import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(
      title: "Hospital Management",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _mySelection;

  final String url = "http://192.168.0.121:9010/api/getdepartment";

  List data=[]; //edited line

  Future<String> getSWData() async {
    var res =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    // ignore: avoid_print
    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Hospital Management"),
      ),
      body: Column(
        children: [
          Center(
            child: DropdownButton(
              items: data.map((item) {
                return DropdownMenuItem(
                  child: Text(item['name']),
                  value: item['Dept_ID'].toString(),
                );
              }).toList(),
              onChanged: (String? newVal) {
                setState(() {
                  _mySelection = newVal;
                });
              },
              value: _mySelection,
            ),
          ),
          // ignore: deprecated_member_use
          RaisedButton(
              child: const Text("Print"),
              onPressed: () {
                // ignore: avoid_print
                print(_mySelection);
              })
        ],
      ),
    );
  }
}
