// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'adddata.dart';
import 'editdata.dart';
import 'person.dart';

void main() {
  setPathUrlStrategy();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/add': (context) => const AddRoute(),
      EditRoute.routeName: (context) => const EditRoute(),
    },
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.search),
            onPressed: () {Navigator.pushNamed(context, '/search');}
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.add),
            onPressed: () {Navigator.pushNamed(context, '/add');}
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
      body: FutureBuilder(
        future: getApi(Uri.parse("http://127.0.0.1:8000/pessoa/getall")),
        builder: (context, snapshot) {
          final List<Person> data;
          if (!snapshot.hasData && snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            data = snapshot.data as List<Person>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.person),
                  title: Text(data[index].name.toString()),
                  subtitle: Text(data[index].age.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {Navigator.pushNamed(context, '/edit', arguments: data[index]);},
                        child: const Text("Edit", style: TextStyle(color: Colors.blue))
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Delete", style: TextStyle(color: Colors.red))
                      )
                    ],
                  ),
                );
              }
            );
          }
        }
      )
    );
  }
}