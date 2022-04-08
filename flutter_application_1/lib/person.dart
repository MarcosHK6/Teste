import 'dart:convert';
import 'package:http/http.dart' as http;

class Person {
  String? cpf;
  String? name;
  int? age;
  String? phone;

  Person({this.cpf, this.name, this.age, this.phone});

  factory Person.fromJson(Map<String, dynamic> json) => _personFromJson(json);
  //factory Person.fromJson(Map<int, dynamic> json) {
    //return Person(cpf: json['cpf'], name: json['name'], age: json['age'], phone: json['phone']);
  //}
}

	
  Person _personFromJson(Map<String, dynamic> json) {
    return Person(
      cpf: json['cpf'] as String,
      name: json['nome'] as String,
      age: json['idade'] as int,
      phone: json['telefone'] as String,
    );
  }

Future<List> getApi(Uri url) async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var parsed = json.decode(utf8.decode(response.bodyBytes));
    List<Person> list = [];
    for (var item in parsed) {
      list.add(Person.fromJson(item));
    }
    return list;
  } else {
    throw Exception('Falha ao carregar lista de cadastros');
  }
}

Future postApi(Uri url, Map<String,dynamic> person) async {
  final response = await http.post(url, headers: {'Content-type': 'application/json'}, body: json.encode(person));

  if (response.statusCode == 200) {
    var parsed = json.decode(utf8.decode(response.bodyBytes));
    return parsed["Mensagem"];
  } else {
    throw Exception('Falha ao adicionar cadastro');
  }
}

Future putApi(Uri url, Map<String,dynamic> person) async {
  final response = await http.put(url, headers: {'Content-type': 'application/json'}, body: json.encode(person));

  if (response.statusCode == 200) {
    var parsed = json.decode(utf8.decode(response.bodyBytes));
    return parsed;
  } else {
    throw Exception('Falha ao editar cadastro');
  }
}

Future delApi(Uri url, Map<String,dynamic> person) async {
  final response = await http.delete(url, headers: {'Content-type': 'application/json'}, body: json.encode(person));

  if (response.statusCode == 200) {
    var parsed = json.decode(utf8.decode(response.bodyBytes));
    return parsed["Mensagem"];
  } else {
    throw Exception('Falha ao excluir cadastro');
  }
}

Future getReport1(Uri url) async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var parsed = json.decode(utf8.decode(response.bodyBytes));
    return parsed;
  } else {
    throw Exception('Falha ao carregar lista de cadastros');
  }
}