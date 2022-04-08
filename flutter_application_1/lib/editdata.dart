import 'package:flutter/material.dart';
import 'person.dart';

class EditRoute extends StatefulWidget {
  const EditRoute({Key? key}) : super(key: key);
  static const routeName = '/edit';

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditRoute> {
  _EditDataState();

@override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as Person;
    final _editFormKey = GlobalKey<FormState>();
    final _cpfController = TextEditingController(text: person.cpf);
    final _nameController = TextEditingController(text: person.name);
    final _ageController = TextEditingController(text: person.age.toString());
    final _phoneController = TextEditingController(text: person.phone);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar cadastro'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 440,
              child: Form(
                key: _editFormKey,
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
                        onPressed: () {
                          if (_editFormKey.currentState!.validate()) {
                            _editFormKey.currentState!.save();
                            putApi(Uri.parse('http://127.0.0.1:8000/pessoa/update'), {'cpf': _cpfController.text, 'nome': _nameController.text, 'idade': int.parse(_ageController.text), 'telefone': _phoneController.text});
                            Navigator.pop(context);
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