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
  TextEditingController _controllerTask = TextEditingController();

  void _addTask(){
    String _typedText = _controllerTask.text;
    Map<String, dynamic> task = Map();
    task["title"] = _typedText;
    task["done"] = false;
    setState(() {
      _taskList.add(task);
    });
    _saveFile();
    _controllerTask.text = "";
  }

  void _saveFile() async {
    final dir = await getApplicationDocumentsDirectory();
    var file = File("${dir.path}/data.json");

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _readFile().then((readReturn){
      setState(() {
        _taskList = json.decode(readReturn);
      });
    });
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
                    controller: _controllerTask,
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
                          _addTask();
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
                  return CheckboxListTile(
                    title: Text(_taskList[index]["title"]),
                      value: _taskList[index]["done"],
                      onChanged: (changedValue){
                        setState(() {
                          _taskList[index]["done"] = changedValue;
                        });
                        _saveFile();
                      }
                  );
                  }
              )
          ),
        ],
      ),
    );
  }
}
