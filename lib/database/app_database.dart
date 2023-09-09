// app_database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'tarefa_dao.dart';

const String tableSql2 =  'CREATE TABLE cursos ( '
    ' id INTEGER PRIMARY KEY, '
    ' nome TEXT, '
    ' info TEXT)';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(path,
      onCreate: (db, version){
        db.execute(TarefaDao.tableSql);
      },
      onUpgrade: (db, oldVersion, newVersion) async{
          var batch = db.batch();
          print("versão antiga: "+ oldVersion.toString());
          print("versão nova:" + newVersion.toString());
          if (newVersion == 2){
            batch.execute(tableSql2);
            print("criando nova tabela cursos");
          }
          await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
      version: 1);
}