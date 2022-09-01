import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class nine extends StatefulWidget {
  const nine({Key? key}) : super(key: key);

  @override
  State<nine> createState() => _nineState();
}

class _nineState extends State<nine> {
  List l = [];
  bool status = false;

  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments');
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
        title: Text("View Json Data nine"),
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
                child: Text(
                  "${m.id}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            title: Text(
              "\n\t PostId = ${m.postId}\n\t name = ${m.name} \n\t email = ${m.email}",
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
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Market({this.postId, this.id, this.name, this.email, this.body});

  Market.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}


