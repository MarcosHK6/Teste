import 'package:flutter/material.dart';
import 'person.dart';

class Report2 extends StatelessWidget {
  const Report2({Key? key}) : super(key: key);

  Future<List<dynamic>> report() async {
    final r = await getReport1(Uri.parse('http://127.0.0.1:8000/relatorio/2'));
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatório 2')),
      body: FutureBuilder(
        future: report(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final data = snapshot.data as List<dynamic>;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Relatório", textScaleFactor: 2, style: TextStyle(fontWeight:FontWeight.bold),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Column(
                      children : [
                      const Text("Pessoa mais nova:\n"),
                      const Text("CPF:"),
                      Text(data[0][0][0].toString()+'\n'),
                      const Text("Nome:"),
                      Text(data[0][0][1].toString()+'\n'),
                      const Text("Idade:"),
                      Text(data[0][0][2].toString()+'\n'),
                      const Text("Telefone:"),
                      Text(data[0][0][3].toString()),
                      ]
                    )
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Column(
                      children : [
                      const Text("Pessoa mais velha:\n"),
                      const Text("CPF:"),
                      Text(data[0][1][0].toString()+'\n'),
                      const Text("Nome:"),
                      Text(data[0][1][1].toString()+'\n'),
                      const Text("Idade:"),
                      Text(data[0][1][2].toString()+'\n'),
                      const Text("Telefone:"),
                      Text(data[0][1][3].toString()),
                      ]
                    )
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Text("Média das idades: " + data[1].toString() + ' anos'),
                  )
                ]
              )
            );
          } 
        }
      )
    );
  }
}