import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _taskList = ["Exemplo 1", "Exemplo 2", "Exemplo 3"];

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
