// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'adddata.dart';
import 'editdata.dart';
import 'person.dart';
import 'report1.dart';
import 'report2.dart';

void main() {
  setPathUrlStrategy();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
      '/add': (context) => const AddRoute(),
      '/report/1': (context) => const Report1(),
      '/report/2': (context) => const Report2(),
      EditRoute.routeName: (context) => const EditRoute(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

TextEditingController txtQuery = TextEditingController();
List<Person> data = [];
List<Person> personList = [];

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: //Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        //children: [
          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.add),
            onPressed: () {Navigator.pushNamed(context, '/add').then((value) => setState((){}));}
          ),
      //  //],
      //),
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
              onTap: () {Navigator.pushNamed(context, '/report/1');}
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Relatório 2"),
              onTap: () {Navigator.pushNamed(context, '/report/2');},
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: txtQuery,
            onChanged: search,
            decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    txtQuery.text = '';
                    search(txtQuery.text);
                  },
                ),
            ),
          ),
          FutureBuilder(
            future: txtQuery.text.isEmpty ? getApi(Uri.parse("http://127.0.0.1:8000/pessoa/getall")) : null,
            builder: (context, snapshot) {
              //final List<Person> data;
              if (!snapshot.hasData && snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                data = snapshot.data as List<Person>;
                if (txtQuery.text.isEmpty) {
                  personList = data;
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: personList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Detalhes", style: TextStyle(fontSize: 28)),
                            content: SingleChildScrollView(
                                child: SizedBox(
                                  width: 300,
                                  height: 350,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text("CPF:", style: TextStyle(fontSize: 18),),
                                      Text(personList[index].cpf ?? '', style: const TextStyle(fontSize: 24),),
                                      const SizedBox(height: 15,),
                                      const Text("Nome:", style: TextStyle(fontSize: 18),),
                                      Text(personList[index].name ?? '', style: const TextStyle(fontSize: 24),),
                                      const SizedBox(height: 15,),
                                      const Text("Idade:", style: TextStyle(fontSize: 18),),
                                      Text(personList[index].age.toString(), style: const TextStyle(fontSize: 24),),
                                      const SizedBox(height: 15,),
                                      const Text("Telefone:", style: TextStyle(fontSize: 18),),
                                      Text(personList[index].phone ?? '', style: const TextStyle(fontSize: 24),)
                                    ],
                                  )
                                )
                            )
                          )
                        );
                      },
                      leading: const Icon(Icons.person),
                      title: Text(personList[index].name.toString()),
                      subtitle: Text(personList[index].age.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/edit', arguments: data[index]).then((value) => setState(() {}));
                            },
                            child: const Text("Edit", style: TextStyle(color: Colors.blue))
                          ),
                          TextButton(
                            child: const Text("Delete", style: TextStyle(color: Colors.red)),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Tem certeza que deseja excluir o cadastro"),
                                  content: const Text("Esta ação não poderá ser desfeita"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Sim"),
                                      onPressed: () async {
                                        final msg = await delApi(Uri.parse('http://127.0.0.1:8000/pessoa/delete/'), {'cpf': data[index].cpf, 'nome': data[index].name, 'idade': data[index].age, 'telefone': data[index].phone});
                                        setState(() {});
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(msg),
                                            actions: <Widget>[
                                              TextButton(onPressed: () {Navigator.pop(context);Navigator.pop(context);}, child: const Text("Ok"))
                                            ],
                                          )
                                        );
                                        //Navigator.of(context).pop();
                                        //Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Não"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ]
                                )
                              );
                            },
                          )
                        ]
                      ),
                    );
                  }
                );
              }
            }
          )
        ]
      )
    );
  }

  void search(String query) {
  if (query.isEmpty) {
    personList = data;
    setState(() {});
    return;
  }

  query = query.toLowerCase();
  //print(query);
  List<Person> result = [];
  for (var p in personList) {
    var name = p.name.toString().toLowerCase();
    if (name.contains(query)) {
      result.add(p);
    }
  }

  personList = result;
  setState(() {});
  }
}