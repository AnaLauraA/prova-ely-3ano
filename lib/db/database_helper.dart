import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:prova_4bim/model/funcionario.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute (
        'CREATE TABLE funcionario('
            'id INTEGER PRIMARY KEY,'
            'nome TEXT,'
            'cargo TEXT,'
            'salario NUMERIC,'
            'cpf TEXT'
        ')'
    );
  }

  Future<int> inserirFuncionario(Funcionario funcionario) async {
    var dbClient = await db;
    var result = await dbClient.insert('funcionario', funcionario.toMap());
    return result;
  }

  Future<List> getFuncionarios() async {
    var dbClient = await db;
    var result =
        await dbClient.query(
            "funcionario",
            columns: [
              "id",
              "nome",
              "cargo",
              "salario",
              "cpf"
            ]
        );

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery('SELECT COUNT(1) FROM funcionario')
    );
  }

  Future<Funcionario > getFuncionario(int id) async {
    var dbClient = await db;
    List<Map> result =
      await dbClient.query(
        "funcionario",
        columns: [
          "id",
          "nome",
          "cargo",
          "salario",
          "cpf",
        ],
        where: 'id = ?',
        whereArgs: [id]
    );

    if (result.length > 0) {
      return new Funcionario.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteFuncionario(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      "funcionario",
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<int> updateFuncionario(Funcionario funcionario) async {
    var dbClient = await db;
    return await dbClient.update(
      "funcionario",
      funcionario.toMap(),
      where:"id = ?",
      whereArgs: [funcionario.id]
    );
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}