import 'package:flutter/material.dart';
import 'package:prova_4bim/model/funcionario.dart';
import 'package:prova_4bim/db/database_helper.dart';

class FuncionarioScreen extends StatefulWidget {
  final Funcionario funcionario;
  FuncionarioScreen(this.funcionario);
  @override
  State<StatefulWidget> createState() => _FuncionarioScreenState();
}

class _FuncionarioScreenState extends State<FuncionarioScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _cargoController;
  TextEditingController _salarioController;
  TextEditingController _cpfController;
  @override
  void initState() {
    super.initState();
    _nomeController =
        TextEditingController(text: widget.funcionario.nome);
    _cargoController =
        TextEditingController(text: widget.funcionario.cargo);
    _salarioController =
        TextEditingController(text: widget.funcionario.salario.toString());
    _cpfController =
        TextEditingController(text: widget.funcionario.cpf);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Funcionario')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child:Column(
          children: [
            Image(
            image: NetworkImage('https://www.siteware.com.br/wp-content/uploads/2017/02/reconhecimento-funcionarios.png')
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText:'Nome'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _cargoController,
              decoration: InputDecoration(labelText:'Cargo'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _salarioController,
              decoration: InputDecoration(labelText:'Salario'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              keyboardType: TextInputType.number,
              controller: _cpfController,
              decoration: InputDecoration(labelText:'CPF'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child:
                (widget.funcionario.id != null) ? Text('Alterar') : Text('Inserir'),
              onPressed: () {
                if (widget.funcionario.id != null) {
                  db.updateFuncionario(Funcionario.fromMap({
                    'id': widget.funcionario.id,
                    'nome': _nomeController.text,
                    'cargo': _cargoController.text,
                    'salario': int.parse(_salarioController.text),
                    'cpf': _cpfController.text,
                  })).then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db.inserirFuncionario(Funcionario(_nomeController.text, _cargoController.text, int.parse( _salarioController.text), _cpfController.text))
                      .then((_) {
                        Navigator.pop(context, 'save');
                  });
                }
              },
            )
          ],
        )
      )
    );
  }
}