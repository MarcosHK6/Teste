// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'list.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () {}
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {}
            )
          ],
        ),
        appBar: AppBar(
          title: const Text("Cadastro de Pessoas"), 
          ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Stack(
                  children: const [
                    Positioned(
                      bottom: 8.0,
                      left: 4.0,
                      child: Text("Cadastro de pessoas", style: TextStyle(color: Colors.white, fontSize: 20))
                    )
                  ]
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://image.shutterstock.com/image-vector/abstract-lines-dots-connect-background-260nw-1492332182.jpg"),
                    fit: BoxFit.cover
                  )
                ),
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text("Relatório 1"),
                onTap: () {}
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text("Relatório 2"),
                onTap: () {},
              )
            ],
          ),
        ),
        body: list
      )
    );
  }
}