import 'package:flutter/material.dart';
import 'package:prova_4bim/model/funcionario.dart';
import 'package:prova_4bim/db/database_helper.dart';

class Funcionario {
  int _id;
  String _nome;
  String _cargo;
  int _salario;
  String _cpf;

  Funcionario(this._nome, this._cargo, this._salario, this._cpf);

  Funcionario.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._cargo = obj['cargo'];
    this._salario = obj['salario'];
    this._cpf = obj['cpf'];
  }

  int get id => _id;
  String get nome => _nome;
  String get cargo => _cargo;
  int get salario => _salario;
  String get cpf => _cpf;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['cargo'] = _cargo;
    map['salario'] = _salario;
    map['cpf'] = _cpf;
    return map;
  }

  Funcionario.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._cargo = map['cargo'];
    this._salario = map['salario'];
    this._cpf = map['cpf'];
  }
}