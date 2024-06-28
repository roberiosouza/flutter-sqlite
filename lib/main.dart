import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuparBanco() async {
    final caminhoBanco = await getDatabasesPath();
    final localBanco = join(caminhoBanco, "banco.db");

    var db =
        await openDatabase(localBanco, version: 1, onCreate: (db, dbVersion) {
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";
      db.execute(sql);
    });
    return db;
  }

  _salvarUsuario() async {
    Database db = await _recuparBanco();
    Map<String, dynamic> dadosUsuario = {"nome": "Rb", "idade": 20};
    int id = await db.insert("usuarios", dadosUsuario);

    return id;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
