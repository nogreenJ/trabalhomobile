import 'package:flutter/material.dart';
import '../database/contato_dao.dart';
import '../models/contato.dart';
import 'contatoform.dart';

class ListaContato extends StatefulWidget {
  List<Contato> _contatos = [];

  @override
  State<StatefulWidget> createState() {
    return ListaContatoState();
  }
}

class ListaContatoState extends State<ListaContato> {
  ContatoDao dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Contatos"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Future future =
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormContato();
            }));
            future.then((contato) {
              setState(() {});
            });
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Contato>>(
            initialData: [],
            future: dao.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data != null) {
                    final List<Contato>? contatos = snapshot.data;
                    return ListView.builder(
                        itemCount: contatos!.length,
                        itemBuilder: (context, indice) {
                          final contato = contatos[indice];
                          return ItemContato(context, contato);
                        });
                  }
                default:
                  return Center(
                    child: Text("Carregando"),
                  );
              }
              return Center(child: Text("Nenhum Contato"));
            }));
  }

  Widget ItemContato(BuildContext context, Contato _contato) {
    return GestureDetector(
        onTap: () {
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormContato(contato: _contato);
          }));
          future.then((value) => setState(() {}));
        },
        child: Card(
          child: ListTile(
            title: Text(_contato.nome),
            subtitle: Text(_contato.info()),
            leading: Icon(Icons.add_alert),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    confirmar(context, _contato.id);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.remove_circle, color: Colors.red)),
                ),
              ],
            ),
          ),
        ));
  }

  void confirmar(BuildContext context, int id) {
    AlertDialog alert = AlertDialog(
      title: Text("Confirmação"),
      content: Text("Deseja excluir o contato?"),
      actions: [
        TextButton(
          child: Text("Sim"),
          onPressed: () {
            _excluir(context, id);
          },
        ),
        TextButton(
          child: Text("Não"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _excluir(BuildContext context, int id) {
    dao.delete(id).then((value) => setState(() {}));
  }
}
