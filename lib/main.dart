import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class IPFetcher {
  Future<String> _getIPAddress() {
    final url = 'https://httpbin.org/ip';
    return http.get(url).then((response) {
      String ip = jsonDecode(response.body)['origin'];
      return ip;
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHomePage(title: 'Foo Bar'),
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
  String ipAddress;

  void _setIP(String ipAddr) {
    setState(() {
      ipAddress = ipAddr;
    });
  }

  final ipFetcher = new IPFetcher();

  @override
  void initState() {
    super.initState();

    ipFetcher
        ._getIPAddress()
        .then((ip) => _setIP(ip))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your IP address is:',
            ),
            Text(
              '$ipAddress',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
