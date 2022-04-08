import 'package:flutter/material.dart';
import 'person.dart';

class Report1 extends StatelessWidget {
  const Report1({Key? key}) : super(key: key);

  Future<List<dynamic>> report() async {
    final r = await getReport1(Uri.parse('http://127.0.0.1:8000/relatorio/1'));
    return r;
  }

    Widget createTable(int n, List<dynamic> data) {
    List<TableRow> rows = [];
    rows.add(const TableRow( children: [
      Center(child: Text('Idade', style: TextStyle(fontWeight: FontWeight.bold))),
      Center(child: Text('Pessoas com esta idade', style: TextStyle(fontWeight: FontWeight.bold)))
    ]),);
    for (int i = 0; i < n; ++i) {
      rows.add(TableRow( children: [
        Center(child: Text(data[i][0].toString())),
        Center(child: Text(data[i][1].toString()))
      ]));
    }
    return Table(border: TableBorder.all(width: 1.0, color: Colors.black), children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatório 1')),
      body: FutureBuilder(
        future: report(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final data = snapshot.data as List<dynamic>;
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Relatório", textScaleFactor: 2, style: TextStyle(fontWeight:FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(175.0, 10.0, 175.0, 20.0),
                  child: createTable(data.length, data)
                )
              ]
            );
          } 
        }
      )
    );
  }
}