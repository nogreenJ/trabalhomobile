import 'package:flutter/material.dart';
import '../database/tarefa_dao.dart';
import '../models/tarefa.dart';
import 'form.dart';

class ListaTarefa extends StatefulWidget {
  List<Tarefa> _tarefas = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTarefaState();
  }
}

class ListaTarefaState extends State<ListaTarefa> {
  TarefaDao dao = TarefaDao();

  @override
  Widget build(BuildContext context) {
    //   widget._tarefas.add(Tarefa('preparar aula TDM', 'postar classroom'));
    //   widget._tarefas.add(Tarefa('orientação TCC1', 'pelo meet'));
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tarefas"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Future future =
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormTarefa();
            }));
            future.then((tarefa) {
              setState(() {});
            });
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Tarefa>>(
            initialData: [],
            future: dao.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data != null) {
                    final List<Tarefa>? tarefas = snapshot.data;
                    return ListView.builder(
                        itemCount: tarefas!.length,
                        itemBuilder: (context, indice) {
                          final tarefa = tarefas[indice];
                          return ItemTarefa(context, tarefa);
                        });
                  }
                default:
                  return Center(
                    child: Text("Carregando"),
                  );
              }
              return Center(child: Text("Nenhuma Tarefa"));
            }));
  }

  Widget ItemTarefa(BuildContext context, Tarefa _tarefa) {
    return GestureDetector(
      onTap: (){
        final Future future = Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return FormTarefa(tarefa: _tarefa);
            }));
        future.then((value) => setState((){}));
      },
      child:    Card(
        child: ListTile(
          title: Text(_tarefa.descricao),
          subtitle: Text(_tarefa.obs),
          leading: Icon(Icons.add_alert),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              GestureDetector(
                onTap: (){ _excluir(context, _tarefa.id);},
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.remove_circle,
                  color : Colors.red)
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  void _excluir(BuildContext context, int id){
    dao.delete(id).then((value) => setState((){}));
  }
}
