import 'package:flutter/material.dart';
import '../models/contato.dart';
import '../components/editor.dart';
import '../database/contato_dao.dart';

class FormContato extends StatefulWidget {
  final Contato? contato;
  FormContato({this.contato});

  @override
  State<StatefulWidget> createState() {
    return FormContatoState();
  }
}

class FormContatoState extends State<FormContato> {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorEndereco = TextEditingController();
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorFone = TextEditingController();
  int? _id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form de Contatos"),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Editor(_controladorNome, "Contato", "Informe o nome",
                      Icons.person),
                  Editor(_controladorEndereco, "Endereço", "Informe o endereço",
                      Icons.place),
                  Editor(_controladorEmail, "Email", "Informe o email",
                      Icons.email),
                  Editor(_controladorFone, "Telefone", "Informe o telefone",
                      Icons.phone),
                  ElevatedButton(
                      onPressed: () {
                        criarContato(context);
                      },
                      child: Text("Salvar"))
                ],
              ))),
    );
  }

  void criarContato(BuildContext context) {
    ContatoDao dao = ContatoDao();
    if (_id != null){ // alteração
      final contato = Contato(_id!,
          _controladorNome.text, _controladorEndereco.text,
          _controladorFone.text, _controladorEmail.text);
      dao.update(contato).then((id) => Navigator.pop(context));
    } else {
      final contato = Contato(_id!,
          _controladorNome.text, _controladorEndereco.text,
          _controladorFone.text, _controladorEmail.text);
      dao.save(contato).then((id) {
        print("contato incluído: " + id.toString());
        Navigator.pop(context);
      });
    }
    SnackBar snackBar = SnackBar(content: Text("Contato atualizado!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    if (widget.contato != null){
      _id = widget.contato!.id;
      _controladorNome.text = widget.contato!.nome;
      _controladorEndereco.text = widget.contato!.endereco;
      _controladorFone.text = widget.contato!.fone;
      _controladorEmail.text = widget.contato!.email;
    }
  }
}
