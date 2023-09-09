import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contato.dart';
import 'app_database.dart';

class ContatoDao {
  static const String _tableName = "contatos";
  static const String _id = "id";
  static const String _nome = "nome";
  static const String _endereco = "endereco";
  static const String _fone = "fone";
  static const String _email = "email";

  static const String tableSql = 'CREATE TABLE tarefas ( '
      ' id INTEGER PRIMARY KEY, '
      ' nome TEXT, '
      ' endereco TEXT, '
      ' fone TEXT, '
      ' email TEXT)';


  Map<String, dynamic> toMap(Contato contato){
    final Map<String, dynamic> contatoMap = Map();
    contatoMap[_nome] = contato.nome;
    contatoMap[_endereco] = contato.endereco;
    contatoMap[_fone] = contato.fone;
    contatoMap[_email] = contato.email;
    return contatoMap;
  }

  Future<int> save(Contato contato) async{
    final Database db = await getDatabase();
    Map<String, dynamic> contatoMap = toMap(contato);
    return db.insert(_tableName, contatoMap);
  }

  Future<int> update(Contato contato) async{
    final Database db = await getDatabase();
    Map<String, dynamic> contatoMap = toMap(contato);
    return db.update(_tableName, contatoMap, where: 'id = ?',
        whereArgs: [contato.id]);
  }

  Future<int> delete(int id ) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  List<Contato> toList (List<Map<String, dynamic>> result){
    final List<Contato> contatos = [];
    for (Map<String, dynamic> row in result){
      final Contato contato = Contato(row[_id],
          row[_nome],
          row[_endereco],
          row[_fone],
          row[_email]);
      contatos.add(contato);
    }
    return contatos;
  }
  Future<List<Contato>> findAll() async{
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contato> contatos = toList(result);
    return contatos;
  }
}
