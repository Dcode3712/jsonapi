import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class eight extends StatefulWidget {
  const eight({Key? key}) : super(key: key);

  @override
  State<eight> createState() => _eightState();
}

class _eightState extends State<eight> {

  bool status = false;
  Market? m;
  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
     Map l = jsonDecode(response.body);
      m = Market.fromJson(l);
    } else {
      Text("Server Down!!!!");
    }

    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Json Data eight"),
      ),
      body: status ? ListTile(leading: Text("${m!.id}"),title: Text("\n\tUser Id = ${m!.userId}\n\tTitle =${m!.title}"),subtitle: Text("\n\t Body: ${m!.body}"),) :Text("Loading"),
    );
  }
}

class Market {
  int? userId;
  int? id;
  String? title;
  String? body;

  Market({this.userId, this.id, this.title, this.body});

  Market.fromJson( json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
