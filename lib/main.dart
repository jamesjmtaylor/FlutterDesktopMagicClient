// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
//Use Future/FutureBuilder(UI) for one time events
//Use Stream/StreamBuilder(UI) for multiple events
Future<String> getCards() async {
  var request = http.Request('GET', Uri.parse('https://api.magicthegathering.io/v1/cards?page=0'));
  http.StreamedResponse response = await request.send();
  // if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  // } else {
  //   throw Exception(response.reasonPhrase);
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: CardsWidget(),
    );
  }
}

class CardsWidget extends StatefulWidget {
  @override
  _CardsWidgetState createState() => _CardsWidgetState();
}

class _CardsWidgetState extends State<CardsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getCards(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ? Scaffold(
              appBar: AppBar(
                title: const Text('Welcome to Flutter'),
              ),
              body: Center(
                child: Text(snapshot.data),
              )
          ) : const CircularProgressIndicator();
        });
  }
}

