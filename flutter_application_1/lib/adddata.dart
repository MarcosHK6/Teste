import 'package:flutter/material.dart';
import 'package:flutter_application_1/person.dart';

class AddRoute extends StatefulWidget {
  const AddRoute({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddRoute> {
  _AddDataState();

  final _addFormKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar cadastro'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 440,
              child: Form(
                key: _addFormKey,
                child: 
                Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      controller: _cpfController,
                      decoration: const InputDecoration(
                        labelText: 'CPF',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o CPF';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o nome';
                        }
                        return null;
                      },
                    ),
                      //),
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        labelText: 'Idade',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira a idade';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telefone',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o telefone';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_addFormKey.currentState!.validate()) {
                            _addFormKey.currentState!.save();
                            final msg = await postApi(Uri.parse('http://127.0.0.1:8000/pessoa/add'), {'cpf': _cpfController.text, 'nome': _nameController.text, 'idade': int.parse(_ageController.text), 'telefone': _phoneController.text});
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(msg),
                                actions: <Widget>[
                                  TextButton(onPressed: () {Navigator.pop(context);Navigator.of(context).pop();}, child: const Text("Ok"))
                                ],
                              )
                            );
                          }
                        },
                        child: const Text('Salvar', style: TextStyle(color: Colors.white)),
                      )
                    ),
                  ],
                )
              )
            ),
          ),
        ),
      )
    );
  }
}