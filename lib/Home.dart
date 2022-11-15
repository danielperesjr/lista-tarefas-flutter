import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _taskList = [];

  void _saveFile() async {
    final dir = await getApplicationDocumentsDirectory();
    var file = File("${dir.path}/data.json");

    Map<String, dynamic> task = Map();
    task["títle"] = "Ir ao mercado";
    task["done"] = false;
    _taskList.add(task);

    String data = json.encode(_taskList);
    file.writeAsString(data);
  }

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/data.json");
  }

  Future<String> _readFile() async{
    try{
      final file = await _getFile();
      return file.readAsString();
    }catch(e){
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.indigo,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: (){
           showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text("Adicionar Tarefa"),
                  content: TextField(
                    decoration: InputDecoration(
                      labelText: "Digite a sua tarefa"
                    ),
                    onChanged: (text){

                    },
                  ),
                  actions: [
                    MaterialButton(
                      child: Text("Cancelar"),
                      onPressed:() => Navigator.pop(context),
                    ),
                    MaterialButton(
                        child: Text("Salvar"),
                      onPressed:(){
                        Navigator.pop(context);
                      }
                    ),
                  ],
                );
              }
          );
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: _taskList.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(_taskList[index]),
                    );
                  }
              )
          ),
        ],
      ),
    );
  }
}
