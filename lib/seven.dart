import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class seven extends StatefulWidget {
  const seven({Key? key}) : super(key: key);

  @override
  State<seven> createState() => _sevenState();
}

class _sevenState extends State<seven> {
  List l = [];
  bool status = false;

  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      l = jsonDecode(response.body);
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
        title: Text("View Json Data seven"),
      ),
      body: ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          Market m = Market.fromJson(l[index]);

          return ListTile(
            leading: Container(
                height: 70,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.greenAccent.shade100),
                child: Text("${m.id}",style: TextStyle(fontWeight: FontWeight.bold),
                )),
            title: Text(
              "\n\t userId = ${m.userId}\n\t title = ${m.title}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "\n\t Body: = ${m.body}",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
          );
        },
      ),
    );
  }
}

class Market {
  int? userId;
  int? id;
  String? title;
  String? body;

  Market({this.userId, this.id, this.title, this.body});

  Market.fromJson(Map<String, dynamic> json) {
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
