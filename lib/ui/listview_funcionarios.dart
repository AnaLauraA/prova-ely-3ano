import 'package:flutter/material.dart';
import 'package:prova_4bim/model/funcionario.dart';
import 'package:prova_4bim/db/database_helper.dart';
import 'package:prova_4bim/ui/funcionario_screen.dart';

class ListViewFuncionarios extends StatefulWidget {
  @override
  _ListViewFuncionariosState createState() => _ListViewFuncionariosState();
}

class _ListViewFuncionariosState extends State<ListViewFuncionarios> {
  List<Funcionario> items = new List();

  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    db.getFuncionarios().then((funcionarios) {
      setState(() {
        funcionarios.forEach((funcionario) {
          items.add(Funcionario.fromMap(funcionario));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Funcionarios'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(
                children: [
                  Divider(height: 5.0),
                  ListTile(
                    title: Text(
                      '${items[position].nome}',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '${items[position].cargo} ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          )
                        ),
                        Text(
                          '${items[position].salario} ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          )
                        ),
                        Text(
                          '${items[position].cpf}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          )
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _deleteFuncionario(
                            context, items[position], position
                          )
                        )
                      ]
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 15.0,
                      child: Text(
                        '${items[position].id}',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () => _navigateToFuncionario(
                      context,
                      items[position],
                    )
                  ),
                ]
              );
            }
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewFuncionario(
            context
          ),
        ),
      ),
    );
  }

  void _deleteFuncionario(BuildContext context, Funcionario funcionario, int position) async {
    db.deleteFuncionario(funcionario.id).then((funcionarios) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToFuncionario(BuildContext context, Funcionario funcionario) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FuncionarioScreen(funcionario)),
    );
    if (result == 'update') {
      db.getFuncionarios().then((funcionarios) {
        setState(() {
          items.clear();
          funcionarios.forEach((funcionario) {
            items.add(Funcionario.fromMap(funcionario));
          });
        });
      });
    }
  }

  void _createNewFuncionario(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FuncionarioScreen(Funcionario('', '', 0, ''))),
    );
    if (result == 'save') {
      db.getFuncionarios().then((funcionarios) {
        setState(() {
          items.clear();
          funcionarios.forEach((funcionario) {
            items.add(Funcionario.fromMap(funcionario));
          });
        });
      });
    }
  }
}