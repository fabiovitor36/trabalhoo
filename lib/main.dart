import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaListaDeTarefas(),
      debugShowCheckedModeBanner: false, // Remover o banner de debug
    );
  }
}

class TelaListaDeTarefas extends StatefulWidget {
  @override
  _TelaListaDeTarefasState createState() => _TelaListaDeTarefasState();
}

class _TelaListaDeTarefasState extends State<TelaListaDeTarefas> {
  List<String> tarefas = [];

  void adicionarTarefa() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String textoTarefa = '';
        return AlertDialog(
          title: Text('Adicionar ou Editar Tarefa'),
          content: TextField(
            onChanged: (value) {
              textoTarefa = value;
            },
            controller: TextEditingController(text: textoTarefa), // Controller para edição
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('SALVAR'),
              onPressed: () {
                setState(() {
                  if (textoTarefa.isNotEmpty) {
                    if (tarefas.contains(textoTarefa)) {
                      // Se a tarefa já existir, edita ela
                      int index = tarefas.indexOf(textoTarefa);
                      tarefas[index] = textoTarefa;
                    } else {
                      // Caso contrário, adiciona ela à lista
                      tarefas.add(textoTarefa);
                    }
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(tarefas[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editarTarefa(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removerTarefa(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarTarefa,
        child: Icon(Icons.add),
      ),
    );
  }

  void _editarTarefa(int index) {
    String textoTarefa = tarefas[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Tarefa'),
          content: TextField(
            onChanged: (value) {
              textoTarefa = value;
            },
            controller: TextEditingController(text: textoTarefa), // Controller para edição
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('SALVAR'),
              onPressed: () {
                setState(() {
                  if (textoTarefa.isNotEmpty) {
                    tarefas[index] = textoTarefa;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
