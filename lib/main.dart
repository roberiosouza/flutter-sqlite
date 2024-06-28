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

    var retorno =
        await openDatabase(localBanco, version: 1, onCreate: (db, dbVersion) {
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";
      db.execute(sql);
    });
    print("Aberto: " + retorno.isOpen.toString());
  }

  @override
  Widget build(BuildContext context) {
    _recuparBanco();
    return const Placeholder();
  }
}
