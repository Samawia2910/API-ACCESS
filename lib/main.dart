import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Main(),

      ),
    );
  }
}
class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List<dynamic> services = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // final response = await http.get('https://pcc.edu.pk/ws/bscs2020/services.php');
    const url = 'https://pcc.edu.pk/ws/bscs2020/services.php';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      setState(() {
        services = data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ID: ${services[index]["id"]}"),
              SizedBox(height: 10),
              Text("Title: ${services[index]["title"]}"),
              SizedBox(height: 10),
              Text("Description: ${services[index]["description"]}"),
              SizedBox(height: 20),
              Text("status: ${services[index]["status"]}"),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}