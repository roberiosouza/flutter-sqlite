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

  _listarUsuarios() async {
    Database db = await _recuparBanco();
    String sql = "SELECT * FROM usuarios";
    List usuarios = await db.rawQuery(sql);
  }

  _usuarioPorId(int id) async {
    Database db = await _recuparBanco();
    List usuario = await db.query("usuarios",
        columns: ["id", "nome", "idade"], where: "id = ?", whereArgs: [id]);
    return usuario;
  }

  _alterarUsuario(int id) async {
    Database db = await _recuparBanco();
    Map<String, dynamic> usuario = {"nome": "Josef", "idade": 30};
    db.update("usuarios", usuario, where: "id = ?", whereArgs: [id]);
  }

  _deletaUsuario(int id) async {
    Database db = await _recuparBanco();
    db.delete("usuarios", where: "id = ?", whereArgs: [id]);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
